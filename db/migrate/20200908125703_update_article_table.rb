class UpdateArticleTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :updated_att, :updated_at
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
