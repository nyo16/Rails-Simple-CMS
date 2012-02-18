class Article < ActiveRecord::Base

  after_update :assign_tags
  after_save :assign_tags

  belongs_to :category

  attr_writer :tag_names

  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings

  validates :title, :presence => true
	validates :content, :presence => true
	validates :category_id, :presence => true
	validates :published, :presence => true

  has_attached_file :photo,
										:url  => "/article/:id/:style_img_:id.:extension",
                  	:path => ":rails_root/public/articles/:id/:style_img_:id.:extension",
                  	:styles => {:medium => "300>", :small => "100>" }

  def tag_names
    @tag_names || tags.map(&:name).join(', ')
  end

  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/,\s+/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end

end

