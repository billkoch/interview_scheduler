json.interviews @unassigned_interviews do |json, interview|
  json.id interview.id
  json.room interview.room
  json.scheduled_at interview.scheduled_at
  json.a_class interview.a_class
  json.position interview.position.title
end