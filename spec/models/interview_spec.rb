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
      Given!(:interview_in_future) { FactoryGirl.create(:interview, :unassigned, scheduled_at: now + 15.minute ) }
      When(:available_interviews) { Interview.next_interview_for_position(interview_in_future.position) }
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

    context 'interviews assigned at the same time' do
      time = Time.now + 10.minutes
      Given!(:earlier_interview) { FactoryGirl.create(:interview, scheduled_at: time) }
      Given!(:later_interview) { FactoryGirl.create(:interview, scheduled_at: earlier_interview.scheduled_at) }
      Given!(:already_scheduled) { Interview.next_interview_for_position(earlier_interview.position) }
      When(:new_available_interviews) { Interview.next_interview_for_position(earlier_interview.position) }
      Then { new_available_interviews.should_not be_nil }
    end
  end

  describe 'get_unscheduled' do
    context 'assigned' do
      Given!(:interview_already_assigned) { FactoryGirl.create(:interview, :assigned) }
      When(:unscheduled_interview) { Interview.get_unscheduled }
      Then { unscheduled_interview.length.should eq(0)}
    end

    context 'unassigned' do
      Given!(:unassigned_interview) { FactoryGirl.create(:interview, :unassigned) }
      When(:new_interviews) { Interview.get_unscheduled }
      Then { new_interviews.length.should eq(1)}
    end
  end

  describe 'get_scheduled' do
    context 'assigned' do
      Given!(:interview_already_assigned) { FactoryGirl.create(:interview, :assigned) }
      When(:new_interviews) { Interview.get_scheduled }
      Then { new_interviews.length.should eq(1)}      
    end

    context 'unassigned' do
      Given!(:unassigned_interview) { FactoryGirl.create(:interview, :unassigned) }
      When(:new_interviews) { Interview.get_scheduled }
      Then { new_interviews.length.should eq(0)}
    end
  end
end 