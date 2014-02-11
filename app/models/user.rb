class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :user_level
  validates :email, presence: true,
            uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
  validates :user_level, presence: true

  has_many :posts

end
