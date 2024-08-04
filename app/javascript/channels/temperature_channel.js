import consumer from "channels/consumer"

consumer.subscriptions.create("TemperatureChannel", {
  connected() {
    console.log("Connected to TemperatureChannel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.action === "analog") {
      console.log(data);

      const intValue = parseInt(data.value, 10);
      const targetElement = document.getElementById(`temp_${data.index}`);
      if (targetElement) { // 요소가 존재하는지 확인
        targetElement.innerText = intValue;
      }
    }
  }
});
