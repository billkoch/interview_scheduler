class Interview < ActiveRecord::Base
  attr_accessible :room, :scheduled_at, :position, :a_class

  belongs_to :interviewee
  belongs_to :position

  validates :room, presence: true, length: { maximum: 50 }
  validates :position, presence: true
  validates :scheduled_at, presence: true
  validates :a_class, presence: true

  scope :unassigned, where(interviewee_id: nil)
  scope :assigned, where("interviewee_id IS NOT NULL")
  scope :order_by_room, order('room')
  scope :for_position, lambda { |position| where(position_id: position) }
  scope :scheduled_after, lambda { |time| where('scheduled_at >= ?', time) }
  scope :not_during, lambda { |time| where('scheduled_at > ? or scheduled_at < ?', time + 1.minutes, time - 1.minutes)}
  scope :for_class, lambda { |a_class| where(a_class: a_class)}

  def self.next_interview_for_position(position, scheduled_at=Time.now, class_a = 'A', other_interview_time=Time.now)
    puts "in order => #{for_position(position).scheduled_after(scheduled_at).unassigned.for_class(class_a).not_during(other_interview_time).order('scheduled_at asc').inspect}"
    for_position(position).scheduled_after(scheduled_at).unassigned.for_class(class_a).not_during(other_interview_time).order('scheduled_at asc').first
  end

  def self.get_unscheduled
    unassigned.order_by_room
  end

  def self.get_scheduled
    assigned.order_by_room
  end
end
