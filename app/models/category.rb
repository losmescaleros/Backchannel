class Category < ActiveRecord::Base
  attr_accessible :approved, :name
  after_initialize :default_values

  validates :name, presence: true, length: { in: 5..200 } #names shouldn't be overly long, but we need something
  has_many :posts

  def posts
    Post.where('category_id = ?', self.id)
  end

  def <=>(other)
    self.name<=>other.name
  end

  private
  def default_values
    self.approved ||= false
  end
end
