class Interview < ActiveRecord::Base
  attr_accessible :room, :scheduled_at

  belongs_to :interviewee
  belongs_to :position

  validates :room, presence: true, length: { maximum: 50 }
  validates :position, presence: true
  validates :scheduled_at, presence: true

  scope :unassigned, where(interviewee_id: nil)
  scope :for_position, lambda { |position| where(position_id: position) }
  scope :scheduled_after, lambda { |time| where('scheduled_at >= ?', time) }

  def self.next_interview_for_position(position, scheduled_at=Time.now)
    for_position(position).scheduled_after(scheduled_at).unassigned.order('scheduled_at asc').limit(1).first
  end
end
