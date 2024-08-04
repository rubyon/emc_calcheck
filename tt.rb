require 'socket'
require 'websocket-client-simple'
require 'json'
require 'active_record'
require 'mysql2'
require './app/models/application_record'
require './app/models/temperature'
require 'timeout'

begin
  Timeout::timeout(300) do  # 10초를 초 단위로 환산한 값
    $stdout.sync = true
    TIMEOUT = 10
    sleep(1)
    def connect_websocket
      ws = WebSocket::Client::Simple.connect('ws://192.168.0.222:3000/cable')
      ws.on :open do
        puts "WebSocket connection opened."
        ws.send({ "command": "subscribe", "identifier": "{\"channel\":\"TemperatureChannel\"}" }.to_json)
      end
      ws.on :close do |e|
        puts "WebSocket connection closed: #{e.code}, #{e.reason}"
        sleep 1
        $ws = connect_websocket # 재연결 시도
      end
      ws.on :error do |e|
        puts "WebSocket error: #{e.message}"
      end
      ws
    end

    def subscribe_channel(ws)
      ws.on :open do
        ws.send({ "command": "subscribe", "identifier": "{\"channel\":\"TemperatureChannel\"}" }.to_json)
      end
    end

    def send_message(ws, action, index, value)
      message = {
        command: 'message',
        identifier: '{"channel":"TemperatureChannel"}',
        data: {
          action: action,
          index: index,
          value: value
        }.to_json
      }

      ws.send(message.to_json) if ws.open?
    end

    def setup_server_socket(port)
      server_socket = Socket.new(:INET, :STREAM)
      server_socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
      server_address = Socket.pack_sockaddr_in(port, '0.0.0.0')
      server_socket.bind(server_address)
      server_socket.listen(5)
      puts "Server is running on port #{port}..."
      server_socket
    end

    server_socket = setup_server_socket(9999)

    ActiveRecord::Base.establish_connection(
      :adapter => "mysql2",
      :host => "127.0.0.1",
      :port => 43306,
      :username => "root",
      :password => "emc98010~!@",
      :database => "emc-calcheck-db"
    )

    $save = ARGV[0] ? ARGV[0] == 'true' : true

    loop do
      begin
        client_socket, client_addrinfo = server_socket.accept
        client_ip = client_addrinfo.ip_address
        puts "Client connected: #{client_ip}"

        if client_ip == "192.168.0.3"

          $ws = connect_websocket

          subscribe_channel($ws)

          loop do
            begin
              data = client_socket.recv(1024)
              break if data.empty?
              hex_data = data.delete_prefix('AA').unpack('H*').first
              # Extract and reverse floats
              puts "#{DateTime.now} ##### #{hex_data}"
              floats = hex_data.scan(/.{8}/).map do |hex|
                [hex].pack('H*').reverse.unpack('g').first
              end
              # 역순으로 출력
              floats.each_with_index do |float, index|
                # puts "온도값 #{index}: #{float}"
                begin
                  send_message($ws, "analog", index, float)
                rescue
                  puts "Send Message Error!!!!!"
                end
                $save = true if (11..20).include?(Time.now.to_i % 60)
                if (0..10).include?(Time.now.to_i % 60) and $save == true
                  puts "##### Save!"
                  @temperature = Temperature.new
                  floats.each_with_index do |float, index|
                    break if index > 14 # temp_14가 최대 인덱스이므로 그 이상은 처리하지 않음
                    @temperature.send("temp_#{index}=", float)
                  end
                  @temperature.save
                  $save = false
                  sleep(1)
                end
              end
            rescue
              puts "Data Error!!!!!"
            end
          end
        end
      rescue
        puts "RESET!!!!!"
      end
    end
  end
rescue Timeout::Error
  puts "10초가 지났으므로 코드를 다시 시작합니다. #{$save}"
  ActiveRecord::Base.connection.disconnect!
  exec "ruby #{$0} #{$save}"
end
