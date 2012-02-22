class Article < ActiveRecord::Base

  after_save :assign_tags, :cache_expiration
  after_destroy :cache_expiration
  before_save :default_values

  include ActionView::Helpers::TextHelper  # for using 'truncate' method on prettify_permalink
  before_validation :prettify_permalink

  belongs_to :category
  belongs_to :gallery

  attr_writer :tag_names

  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings

  validates :title, :presence => true
  validates :title, :length => { :maximum => 250 }
	validates :content, :presence => true
	validates :category_id, :presence => true
	validates :published, :presence => true
  validates :permalink, :presence => true
  validates :permalink, :length => { :maximum => 250 }
  validates_uniqueness_of :permalink, :scope => :category_id
  validates :meta_description, :length => { :maximum => 250 }
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  has_attached_file :photo,
										:url  => "/articles/:id/:style_img_:id.:extension",
                  	:path => ":rails_root/public/articles/:id/:style_img_:id.:extension",
                  	:styles => {:medium => "300>", :small => "100>" }

  scope :published_only, where(published: true).order("promote Desc, created_at Desc")



  def prettify_permalink
    # parameterize function is nice but not as good as below
    self.permalink = truncate(self.permalink.strip.gsub(/[\~]|[\`]|[\!]|[\@]|[\#]|[\$]|[\%]|[\^]|[\&]|[\*]|[\(]|[\)]|[\+]|[\=]|[\{]|[\[]|[\}]|[\]]|[\|]|[\\]|[\:]|[\;]|[\"]|[\']|[\<]|[\,]|[\>]|[\.]|[\?]|[\/]/,"").gsub(/\s+/,"-").downcase, length: 50, separator: "-", omission: "")
    category = truncate(self.category.name.strip.gsub(/[\~]|[\`]|[\!]|[\@]|[\#]|[\$]|[\%]|[\^]|[\&]|[\*]|[\(]|[\)]|[\+]|[\=]|[\{]|[\[]|[\}]|[\]]|[\|]|[\\]|[\:]|[\;]|[\"]|[\']|[\<]|[\,]|[\>]|[\.]|[\?]|[\/]/,"").gsub(/\s+/,"-").downcase, length: 50, separator: "-", omission: "")
    self.final_permalink = category+"/"+self.permalink
  end

  def tag_names
    @tag_names || tags.map(&:name).join(', ')
  end

  private

  def cache_expiration
    ActionController::Base.new.expire_fragment("article_seo_"+self.id.to_s)
    ActionController::Base.new.expire_fragment("article_content_"+self.id.to_s)
    ActionController::Base.new.expire_fragment("category_"+self.category.id.to_s)
  end

  def default_values
    self.promote = 0 if self.promote.nil?
  end

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/,\s+/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end

end

