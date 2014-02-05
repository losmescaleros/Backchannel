class CreateUpVotePosts < ActiveRecord::Migration
  def change
    create_table :up_vote_posts do |t|
      t.user :user
      t.post :post

      t.timestamps
    end
  end
end
