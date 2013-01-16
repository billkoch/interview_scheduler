class BlacklistedEmail < ActiveRecord::Base
  attr_accessible :email

  validates :email, presence: true

  def self.is_blacklisted?(email)
    !(where('email = ?', email).first.nil?)
  end
end
