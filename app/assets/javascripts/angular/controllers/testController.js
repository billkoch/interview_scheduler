function ClosedInterviewsCntrl($scope, $http, channels) {

  channels.getInstance().bind('schedule', function(data) {
    $scope.reload();
  })

  $scope.unassign = function(index) {
    $http.post('interviews/' + $scope.interviews[index].id + '/unassign').error(function(data, status, headers, config) {
      alert('Your changes were not applied. You must be on the UPMC internal network. Please refresh the page.')
    });

    $scope.interviews.splice(index, 1)
  }

  $scope.reload = function() {
    $http.get('closed_interviews.json').success(function(data) {
      $scope.interviews = data['interviews'];
    })
  }

  $scope.reload();
}