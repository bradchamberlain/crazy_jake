# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    text "MyText"
    index 1
    yes_no false
    rating false
    free_form false
  end
end
