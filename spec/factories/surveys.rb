# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey do
    name "MyText"
    customer FactoryGirl.create(:customer)
  end
end
