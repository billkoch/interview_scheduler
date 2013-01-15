require 'spec_helper'
require 'rspec/given'

describe Interviewee do
  describe 'validation' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }

    it { should ensure_length_of(:first_name).is_at_most(50) }
    it { should ensure_length_of(:last_name).is_at_most(50) }
    it { should ensure_length_of(:email).is_at_most(50) }

    it { should_not allow_value('foo').for(:email) }
    it { should allow_value('foo_bar@madeup.com').for(:email) }
  end
end
