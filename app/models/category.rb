# Categories are used to organize posts. Categories can be suggested by users, but they must be approved by 
# an administrator before use. 
class Category < ActiveRecord::Base
  # Categories have a string name and boolean for whether or not they have been approved
  attr_accessible :approved, :name
  after_initialize :default_values

  # Categories require a name, and the name must be between 5 and 200 characters
  validates :name, presence: true, length: { in: 5..200 } #names shouldn't be overly long
  has_many :posts

  # The posts that belong to this category
  def posts
    Post.where('category_id = ?', self.id)
  end

  # Comparator definition. Categories are ordered by name alphabetically
  def <=>(other)
    self.name<=>other.name
  end

  private
  
  # Categories are not approved by default
  def default_values
    self.approved ||= false
  end
end
