class Category < ActiveRecord::Base
  has_many :pages
  has_many :articles
end

