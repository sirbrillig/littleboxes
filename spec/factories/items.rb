# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "My Item"
    aliases "Foo, Bar"
    weight 1
  end
end
