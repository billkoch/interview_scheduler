class Interviewee < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name

  has_many :interviews

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: /\w+@\w+/ }
end
