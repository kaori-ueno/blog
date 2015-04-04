class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :encrypted_password
      t.date :created_at
      t.date :updated_at

      t.timestamps null: false
    end
  end
end
