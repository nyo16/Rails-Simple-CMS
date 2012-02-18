# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "MyString"
    content "MyText"
    meta_description "MyString"
    author "MyString"
    category_id ""
    published false
    gallery_id 1
    promote 1
  end
end
