class Post < ActiveRecord::Base
  attr_accessible :deleted, :time, :title, :txt, :user
end
