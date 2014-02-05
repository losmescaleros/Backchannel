class CreateUpVoteComments < ActiveRecord::Migration
  def change
    create_table :up_vote_comments do |t|
      t.user :user
      t.comment :comment

      t.timestamps
    end
  end
end
