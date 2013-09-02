FactoryGirl.define do
  factory :product do
    title        "MyString"
    description  "MyText"
    image_url    "MyString"
    price        9.99

  factory :product_ruby, class:Product do
    title       "Programming Ruby 1.9"
    description "test"
    price       49.50
    image_url   "ruby.png"
    end
  end
end
    
