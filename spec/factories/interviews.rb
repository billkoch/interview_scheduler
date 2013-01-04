FactoryGirl.define do
  factory :interview do
    scheduled_at { 1.minute.from_now }
    room 'Some Room'
    association :position
  end

  trait :unassigned do
    interviewee nil
  end

  trait :assigned do
    association :interviewee
  end

  trait :software_engineer do
    association :position, :software_engineer_position
  end

  trait :project_manager do
    association :position, :project_manager_position
  end
end