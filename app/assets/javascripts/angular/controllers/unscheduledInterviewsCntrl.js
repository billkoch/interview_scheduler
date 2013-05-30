function UnscheduledInterviewsCntrl($scope, $http) {

  $scope.reload = function() {
    $http.get('open_interviews.json').success(function(data) {
      $scope.interviews = data['interviews'];
    });

    $http.get('interviewees.json').success(function(data) {
      $scope.interviewees = data['interviewees']
    })
  }

  $scope.assignInterview = function(interview) {
    $scope.interviewToBeAssigned = interview
  }

  $scope.assign = function(interviewee, index) {
    var interview = $scope.interviewToBeAssigned;

    if(interview != undefined) {
      $http.post('/interviews/assign', {interview_id: interview.id, interviewee_id: interviewee.id})
      .error(function(data, status, headers, config) {
        alert('Sorry, but your changes were not applied. You must be connected to the UPMC internal network.')
      })
      .success(function() {
        $scope.reload();
        alert('The interview in ' + interview.room + ' at ' + interview.scheduled_at + ' was scheduled for ' + interviewee.first_name + ' ' + interviewee.last_name + '.')
      })
    }
  }

  $scope.reload();
}