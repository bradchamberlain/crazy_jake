# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    text "MyText"
    index 1
    yes_no true
    rating false
    free_form false
    customized false
  end

  factory :custom_question, class: Question do
    text "MyCustom"
    index 2
    yes_no false
    rating false
    free_form false
    customized true
    custom_values "[\"one\",\"two\"]"
    custom_type 0
  end
end
