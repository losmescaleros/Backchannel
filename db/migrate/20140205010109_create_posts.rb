class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :txt
      t.timestamp :time
      t.boolean :deleted
      t.user :user

      t.timestamps
    end
  end
end
