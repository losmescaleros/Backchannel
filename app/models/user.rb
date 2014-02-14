class User < ActiveRecord::Base
  has_secure_password
  # To ensure uniqueness, make sure email address is downcased before save
  before_save { self.email = email.downcase }
  attr_accessible :email, :name, :password, :user_level, :password_confirmation

  after_initialize :default_values

  validates :email, presence: true,
            uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
  validates :user_level, presence: true

  has_many :posts
  has_many :comments
  has_many :up_vote_posts
  has_many :up_vote_comments

  def <=>(other)
    self.name<=>other.name
  end

  def authenticate(email, password) #this may or may not work. If I read the API right, this should return nil if no record was found with the given email and password, or the tuple if it was found
    where(email: email, password: password).first
  end

  private
  def default_values
    self.user_level ||= 0
  end
end
