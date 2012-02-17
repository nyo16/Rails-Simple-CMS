class Gallery < ActiveRecord::Base

  has_many :gallery_images, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :gallery_images
end

