class User < ActiveRecord::Base
  SUPER_ADMIN_USER_LEVEL = 3
  ADMIN_USER_LEVEL = 2
  REGULAR_USER_LEVEL = 1
  VALID_EMAIL = /\A[\w+\-.]+@[\w\-.]+\.[a-z]{2,3}\z/i

  has_secure_password
  # To ensure uniqueness, make sure email address is downcased before save
  before_save { self.email = email.downcase }
  # New users should have a remember_token for a new session
  before_create :create_remember_token

  attr_accessible :email, :name, :password, :user_level, :password_confirmation

  after_initialize :default_values

  validates :email, presence: true,
            uniqueness: true,
            format: {with: VALID_EMAIL}
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

  def admin?
    if(!self.nil?)
      self.user_level == SUPER_ADMIN_USER_LEVEL || self.user_level == ADMIN_USER_LEVEL
    end
  end

  def super_admin?
    if(!self.nil?)
      self.user_level == SUPER_ADMIN_USER_LEVEL
    end
  end

  def promote
    if !self.admin?
      self.update_attribute(:user_level, ADMIN_USER_LEVEL)
    end
  end

  def demote
    if self.admin? && !self.super_admin?
      self.update_attribute(:user_level, REGULAR_USER_LEVEL)
    end
  end

  #Class method to return a blank user for whatever reason a blank user might be needed
  def User.blank_user
    User.new(:name => '[[Deleted]]', :email => 'n@n.n', :user_level => 0)
  end

  # Class method to get a randomly generated token
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # Class method to encrypt some token in SHA1
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  private
    def default_values
      self.user_level ||= 0
    end

    def create_remember_token
      # create a new session token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
