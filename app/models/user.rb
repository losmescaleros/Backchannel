class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :user_level
  after_initialize :default_values

  validates :email, presence: true,
            uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
  validates :user_level, presence: true

  has_many :posts

  def authenticate(email, password)
    where(email: email, password: password).first
  end

  private
  def default_values
    self.user_level ||= 0
  end
end
