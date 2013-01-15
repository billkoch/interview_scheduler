require 'spec_helper'

describe Interview do
  describe 'validation' do
    it { should validate_presence_of(:room) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:scheduled_at) }

    it { should ensure_length_of(:room).is_at_most(50) }
  end

  describe 'next_interview_for_position' do
    context 'interview in the past' do
      now = Time.now
      Given!(:interview_in_past) { FactoryGirl.create(:interview, :unassigned, scheduled_at: now - 1 ) }
      When(:available_interviews) { Interview.next_interview_for_position(interview_in_past.position, now) }
      Then { available_interviews.should be_nil }
    end

    context 'interview in the future' do
      now = Time.now
      Given!(:interview_in_future) { FactoryGirl.create(:interview, :unassigned, scheduled_at: now + 1 ) }
      When(:available_interviews) { Interview.next_interview_for_position(interview_in_future.position, now) }
      Then { available_interviews.should eq(interview_in_future) }
    end

    context 'interview for a different position' do
      Given!(:interview_for_different_position) { FactoryGirl.create(:interview, :project_manager, :unassigned) }
      When(:available_interviews) { Interview.next_interview_for_position(FactoryGirl.create(:position, :software_engineer_position)) }
      Then { available_interviews.should be_nil }
    end

    context 'interview already assigned to interviewee' do
      Given!(:interview_already_assigned) { FactoryGirl.create(:interview, :assigned) }
      When(:available_interviews) { Interview.next_interview_for_position(interview_already_assigned.position) }
      Then { available_interviews.should be_nil }
    end

    context 'multiple unassigned interviews' do
      Given!(:earlier_interview) { FactoryGirl.create(:interview) }
      Given!(:later_interview) { FactoryGirl.create(:interview, position: earlier_interview.position) }
      When(:available_interviews) { Interview.next_interview_for_position(earlier_interview.position) }
      Then { available_interviews.should eq(earlier_interview) }
    end
  end
end