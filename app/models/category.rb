class Category < ActiveRecord::Base
  attr_accessible :approved, :name
  after_initialize :default_values

  validates :name, presence: true, length: { in: 5..200 } #names shouldn't be overly long, but we need something
  has_many :posts

  def posts(id)
    Post.where('category_id = ?', id).sort('')
  end

  def <=>(other)
    self.name<=>other.name
  end

  private
  def default_values
    self.time ||= Time.now.to_formatted_s :rfc822 #picked this up from stackoverflow for getting a correctly formatted timestamp
    self.deleted ||= false
  end
end
