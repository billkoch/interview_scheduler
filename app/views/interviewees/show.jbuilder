json.interviewees @interviewees do |json, interviewee|
  json.id interviewee.id
  json.a_class interviewee.a_class
  json.first_name interviewee.first_name
  json.last_name interviewee.last_name
  json.email interviewee.email
  json.positionIds interviewee.positions.map {|position| position.id}
end