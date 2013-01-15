FactoryGirl.define do
  factory :position do
    title 'Generic Position'
  end

  trait :software_engineer_position do
    title 'Software Engineer'
  end

  trait :project_manager_position do
    title 'Project Manager'
  end
end