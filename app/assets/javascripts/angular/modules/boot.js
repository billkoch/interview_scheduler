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
  value('positionMap', [96, 97, 98, 99, 100, 101, 102, 103])

angular.module('interviewRegistration', ['interviewRegistration.service']).
  run(function(channels) {
    channels.initialize();
  })