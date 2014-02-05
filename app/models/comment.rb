class Comment < ActiveRecord::Base
  attr_accessible :deleted, :time, :txt, :user
end
