class Category < ActiveRecord::Base
  has_many :pages
  has_many :articles

  validates :name, :presence => true
end

