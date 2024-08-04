class TemperatureChannel < ApplicationCable::Channel
  def subscribed
    stream_from "temperature_channel"
  end

  def unsubscribed
    puts "##### disconnected"
    # Any cleanup needed when channel is unsubscribed
  end

  def analog(data)
    Rails.logger.info "Received data on TemperatureChannel: #{data.inspect}"
    ActionCable.server.broadcast("temperature_channel",data)
  end

  def digital(data)
    Rails.logger.info "Received data on TemperatureChannel: #{data.inspect}"
    ActionCable.server.broadcast("temperature_channel",data)
  end

end
