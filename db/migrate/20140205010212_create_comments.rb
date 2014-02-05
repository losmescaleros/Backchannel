class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :txt
      t.timestamp :time
      t.boolean :deleted
      t.user :user

      t.timestamps
    end
  end
end
