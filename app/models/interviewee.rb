class Interviewee < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name

  before_create :populate_positions

  has_many :interviews

  has_and_belongs_to_many :positions

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  def mark(a_class)
    self.a_class = a_class
    self.save
  end

  def can_schedule_for_position(position)
    self.positions.include?(position)
  end

  def remove_position(position)
    self.positions.delete(position)
  end

  def add_position(position)
    self.positions << position
  end

  def has_interview_for_position?(position) 
    self.interviews.where('position_id == ?', position) != []
  end

  def remaining_interviews
    if self.positions.length > 0 && self.positions.length < 6
      1 - self.interviews.length
    else 
      1 - self.interviews.length
    end
  end

  def is_not_booked?
    if self.positions.length > 0 && self.positions.length < 6
      self.interviews.length < 1
    else  
      self.interviews.length < 1
    end
  end

  private 
    def populate_positions
      self.positions = Position.all
    end
end
