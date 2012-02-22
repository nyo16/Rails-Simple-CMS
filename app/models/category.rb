class Category < ActiveRecord::Base
  has_many :pages
  has_many :articles, :dependent => :destroy

  validates :name, :presence => true
  validates :name, :uniqueness => true
end

