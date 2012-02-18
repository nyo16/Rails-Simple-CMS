class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :meta_description
      t.string :author
      t.integer :category_id
      t.boolean :published
      t.integer :gallery_id
      t.integer :promote

      t.timestamps
    end
  end
end

