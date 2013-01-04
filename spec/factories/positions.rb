FactoryGirl.define do
  factory :position do
    name 'Generic Position'
  end

  trait :software_engineer_position do
    name 'Software Engineer'
  end

  trait :project_manager_position do
    name 'Project Manager'
  end
end