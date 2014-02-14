class Post < ActiveRecord::Base
  attr_accessible :deleted, :time, :title, :txt
  after_initialize :default_values

  validates :title, presence: true, length: { in: 5..300 } #title should be there, and also be at least a few words
  validates :txt, presence:true, length: { in: 50..60000 } #we should probably force the text of the post to be interesting
  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :up_vote_posts

  def comments(id)
    Comment.where('post_id = ?', id).order('time ASC')
  end

  def up_votes(id)
    UpVotePost.where('post_id = ?, id')
  end

  def up_vote_count(id)
    up_votes(id).count
  end

  def up_voted?(post_id, user_id) #to determine whether we should let the user upvote something
    UpVotePost.where('post_id = ? AND user_id = ?', post_id, user_id).exists?
  end

  def <=>(other) #defined as the number of upvotes / the days elapsed since creation: high numbers of upvotes will prevent a topic from "sageing"
    up_vote_count(self.id) / (((Time.now - self.time).to_i)/(60*60)) <=> up_vote_count(other.id) / (((Time.now - other.time).to_i)/(60*60))
  end

  private
  def default_values
    self.time ||= Time.now.to_formatted_s :rfc822 #picked this up from stackoverflow for getting a correctly formatted timestamp
    self.deleted ||= false
  end
end
