class UpVoteComment < ActiveRecord::Base
  attr_accessible :user_id, :comment_id

  validates :user_id, presence: true
  validates :comment_id, presence: true

  belongs_to :user
  belongs_to :comment
end
