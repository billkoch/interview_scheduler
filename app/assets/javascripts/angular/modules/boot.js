angular.module('interviewRegistration.service', []).
  value('channels', {
    dispatcher: null,
    channel: null,

    initialize: function() {
      // this.dispatcher = new WebSocketRails('ci.tdc.upmc.com:3000/websocket');
      this.dispatcher = new WebSocketRails('ci.tdc.upmc.com:3000/websocket');
      this.channel = this.dispatcher.subscribe('interviewee_class');
    },

    getInstance: function() {
      return this.channel;
    }
  }).
  value('positionMap', [78, 79, 80, 81, 82, 83, 84, 85, 86])

angular.module('interviewRegistration', ['interviewRegistration.service']).
  run(function(channels) {
    channels.initialize();
  })