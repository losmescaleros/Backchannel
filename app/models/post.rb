class Post < ActiveRecord::Base
  attr_accessible :deleted, :time, :title, :txt, :user_id, :category_id

  belongs_to :user
end
