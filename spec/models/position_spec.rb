require 'spec_helper'

describe Position do
  describe 'validation' do
    it { should validate_presence_of(:title) }
  end
end
