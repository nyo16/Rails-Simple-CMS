class AddFinalPermalinkToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :final_permalink, :string

  end
end
