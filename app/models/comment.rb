class Comment < ActiveRecord::Base
  attr_accessible :deleted, :time, :txt, :user_id, :post_id
end
