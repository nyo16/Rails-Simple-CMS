class AddGalleryIdToPage < ActiveRecord::Migration
  def change
    add_column :pages, :gallery_id, :integer

  end
end
