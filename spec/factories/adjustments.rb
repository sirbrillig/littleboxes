# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :adjustment do
    item nil
    delta 1
    reset false
  end
end
