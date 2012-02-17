class GalleryImage < ActiveRecord::Base

  belongs_to :gallery

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  has_attached_file :image,
    :url  => "/gallery/:style/:id/:filename",
    :path => ":rails_root/public/gallery/:style/:id/:filename",
    :styles => {:thumb => '150x150#', :small  => '400x400>', :large => '800x600>'}


   def to_jq_upload
    {
      "name" => self.image_file_name,
      "size" => self.image_file_size,
      "url" => self.image.url,
      "thumbnail_url" => self.image.url(:thumb),
      "delete_url" => "random",
      "delete_type" => "DELETE"
    }
  end

end
