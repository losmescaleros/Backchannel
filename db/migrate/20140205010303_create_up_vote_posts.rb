class CreateUpVotePosts < ActiveRecord::Migration
  def change
    create_table :up_vote_posts do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
