class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      #フォローするユーザーID
      t.integer :follower_id
      #フォローされるユーザーID
      t.integer :followed_id
      t.timestamps
    end
  end
end
