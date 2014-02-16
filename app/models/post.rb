class Post < ActiveRecord::Base
  attr_accessible :deleted, :time, :title, :txt, :user_id, :category_id
  after_initialize :default_values

  validates :title, presence: true, length: { in: 5..300 } #title should be there, and also be at least a few words
  validates :txt, presence:true, length: { in: 50..60000 } #we should probably force the text of the post to be interesting
  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :up_vote_posts

  public
  def comments
    Comment.where('post_id = ?', self.id).order('time ASC')
  end

  def up_votes
    UpVotePost.where('post_id = ?', self.id)
  end

  def up_vote_count
    up_votes.count
  end

  def up_voted?(user_id) #to determine whether we should let the user upvote something
    UpVotePost.where('post_id = ? AND user_id = ?', self.id, user_id).exists?
  end

  def numerical_value
    self.up_vote_count.to_f / (((Time.now - self.time).to_i)/(3600)).to_f
  end

  def <=>(other) #defined as the number of upvotes / the days elapsed since creation: high numbers of upvotes will prevent a topic from "sageing"
    (self.numerical_value<=>other.numerical_value)
  end

  private
  def default_values
    self.time ||= Time.now.to_formatted_s :rfc822 #picked this up from stackoverflow for getting a correctly formatted timestamp
    self.deleted ||= false
  end
end
