class Comment < ActiveRecord::Base
  attr_accessible :deleted, :time, :txt, :post_id, :user_id
  after_initialize :default_values

  validates :txt, presence:true, length: { in: 10..60000 } #comments can be a bit shorter than posts
  belongs_to :user
  belongs_to :post
  has_many :up_vote_comments

  def up_votes
    UpVoteComment.where('comment_id = ?', self.id)
  end

  def up_vote_count
    up_votes.count
  end

  def up_voted?(user_id) #to determine whether we should let the user upvote something
    UpVoteComment.where('comment_id = ? AND user_id = ?', self.id, user_id).exists?
  end

  def user
    real_user = User.find_by_id(self[:user_id])
    if real_user.nil?
      User.blank_user
    else
      real_user
    end
  end

  def <=>(other)
    self.time <=> other.time
  end

  private
  def default_values
    self.time ||= Time.now.to_formatted_s :rfc822 #picked this up from stackoverflow for getting a correctly formatted timestamp
    self.deleted ||= false
  end
end
