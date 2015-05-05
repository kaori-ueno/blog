class RenameUserIdColumnToArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :user_id, :blog_id
  end
end
