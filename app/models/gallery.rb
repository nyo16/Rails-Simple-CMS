class Gallery < ActiveRecord::Base

  after_save :cache_expiration
  after_destroy :cache_expiration

  has_many :gallery_images, :dependent => :destroy
  has_many :pages

  validates :name, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :gallery_images

  private

  def cache_expiration
    ActionController::Base.new.expire_fragment("gallery_"+self.id.to_s)
  end

end

