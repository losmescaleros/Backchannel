class UpVotePost < ActiveRecord::Base
  attr_accessible :user_id, :post_id

  validates :user_id, presence: true
  validates :post_id, presence: true


  belongs_to :user
  belongs_to :post
end
