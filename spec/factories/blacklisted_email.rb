FactoryGirl.define do
  factory :blacklisted_email do
    email nil
  end

  trait :blacklisted do
    email 'bad_email@aol.com'
  end
end