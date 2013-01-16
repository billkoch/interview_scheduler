require 'spec_helper'

describe BlacklistedEmail do
  describe "validation" do 
    it { should validate_presence_of(:email) }
  end

  describe "checking for blacklisted emails" do
    context 'bad signup' do
      now = Time.now
      Given!(:blacklisted_email) { FactoryGirl.create(:blacklisted_email, :blacklisted) }
      When(:bad_signup) { BlacklistedEmail.is_blacklisted?(blacklisted_email.email) }
      Then { bad_signup.should be_true }
    end

    context 'good signup' do
      now = Time.now
      Given!(:blacklisted_email) { FactoryGirl.create(:blacklisted_email, :blacklisted) }
      When(:bad_signup) { BlacklistedEmail.is_blacklisted?('good_email@gmail.com') }
      Then { bad_signup.should be_false }
    end
  end
end
