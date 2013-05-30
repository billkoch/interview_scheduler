json.interviews @assigned_interviews do |json, interview|
  json.id interview.id
  json.room interview.room
  json.scheduled_at interview.scheduled_at
  json.interviewee_first_name interview.interviewee.first_name
  json.interviewee_last_name interview.interviewee.last_name
  json.interviewee_email interview.interviewee.email
end