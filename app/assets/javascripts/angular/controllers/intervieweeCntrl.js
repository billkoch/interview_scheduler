function IntervieweeCntrl($scope, $http, channels, positionMap) {

  channels.getInstance().bind('update', function(data) {
    $scope.reload();
  })

  $scope.changePosition = function(index, attr) {

    var operation = $scope.interviewees[index].selected[attr] ? '/add_position' : '/remove_position';
    var id = $scope.interviewees[index].id;

    $http.post('/interviewees/' + id + operation, {position_id: positionMap[attr]}).error(function(data, status, headers, config) {
        alert('Sorry, but your changes were not applied. You must be connected to the UPMC internal network.')
    });
  }

  $scope.deleteUser = function(index) {
    var id = $scope.interviewees[index].id;

    $http.post('/interviewees/' + id + '/delete_user').error(function(data, status, headers, config) {
      alert('Sorry, but your changes were not applied. You must be connected to the UPMC internal network.')
    })
    
    $scope.interviewees.splice(index, 1)
  }

  $scope.reload = function() {

    $http.get('interviewees.json').success(function(data) {
      $scope.interviewees = data['interviewees'];

      _.each($scope.interviewees, function(interviewee) {
        interviewee.selected = [];
        for(var i=0; i<positionMap.length; i++) {
          interviewee.selected[i] = _.contains(interviewee.positionIds, positionMap[i])
        }
      });
    })
  }

  $scope.reload();
}