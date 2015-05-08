class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :article_id

      t.timestamps null: false
    end

    add_index :comments, :article_id
  end
end
