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

  describe 'default values' do
    interviewee = Interviewee.create({first_name: 'Test', last_name: 'Wayne', email: 'something@gmail.com'})
    position = Position.create({title: 'Software Engineer'})

    context "positions" do
      interviewee.positions << position
      it "should have positions" do
        interviewee.positions.length.should eq(1)
      end

      context "can_schedule_for_position" do
        it "should return true if interviewee has position" do
          interviewee.positions.clear
          interviewee.positions << position
          interviewee.can_schedule_for_position(position).should be_true
        end
      end

      context "remove_position" do
        it "should be able to remove a position" do
          interviewee.positions.clear
          interviewee.positions << position
          interviewee.remove_position(position)
          interviewee.positions.include?(position).should be_false
        end
      end

      context "add_position" do
        it "should be able to add a position" do
          interviewee.positions.clear
          interviewee.add_position(position)
          interviewee.positions.include?(position).should be_true
        end
      end
    end
  end
end
