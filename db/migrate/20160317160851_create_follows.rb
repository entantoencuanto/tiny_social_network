class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :follower_id, references: :users, index: true, foreign_key: true
      t.integer :followed_id, references: :users, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
