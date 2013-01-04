require 'spec_helper'

describe Interview do
  describe 'validation' do
    it { should validate_presence_of(:room) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:scheduled_at) }

    it { should ensure_length_of(:room).is_at_most(50) }
  end

  describe 'unassigned' do
    let!(:unassigned_interview) { FactoryGirl.create(:interview, :unassigned) }
    let!(:assigned_interview) { FactoryGirl.create(:interview, :assigned) }
    
    it 'does not include Interviews with an Interviewee' do
      Interview.unassigned.should_not include(assigned_interview)
      Interview.unassigned.should include(unassigned_interview)
    end
  end

  describe 'for_position' do
    let!(:software_engineer) { FactoryGirl.create(:interview, :software_engineer) }
    let!(:project_manager) { FactoryGirl.create(:interview, :project_manager) }

    it 'includes positions in the Array' do
      Interview.for_position('Software Engineer').should include(software_engineer)
    end

    it 'does not include positions that were not in the Array' do
      Interview.for_position('Software Engineer').should_not include(project_manager)
    end
  end

  describe 'scheduled_after' do
    it 'includes interviews scheduled at exactly a given time' do
        now = Time.zone.now
        interview_scheduled_now = FactoryGirl.create(:interview, scheduled_at: now)
        Interview.scheduled_after(now).should include(interview_scheduled_now)
    end

    it 'includes Interviews scheduled 1 second after the given time' do
      Timecop.freeze do
        future = FactoryGirl.create(:interview, scheduled_at: 1.second.from_now)
        Interview.scheduled_after(Time.zone.now).should include(future)
      end
    end

    it 'does not include Interviews scheduled 1 second before a given time' do
      Timecop.freeze do
        past = FactoryGirl.create(:interview, scheduled_at: 1.seconds.ago)
        Interview.scheduled_after(Time.zone.now).should_not include(past)
      end
    end
  end
end