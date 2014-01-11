# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    name "HI THERE" + SecureRandom.uuid
  end
end
