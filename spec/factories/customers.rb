# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    name "HI THERE" + SecureRandom.uuid
    payment_received Date.today
  end
  factory :non_active_customer, class: Customer do
    name "IN-ACTIVE" + SecureRandom.uuid
    payment_received Date.today - 1.year
  end
end
