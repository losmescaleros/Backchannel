class UpVotePost < ActiveRecord::Base
  attr_accessible :post_id, :user_id
end
