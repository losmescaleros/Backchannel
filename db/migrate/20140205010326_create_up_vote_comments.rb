class CreateUpVoteComments < ActiveRecord::Migration
  def change
    create_table :up_vote_comments do |t|
      t.integer :user_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
