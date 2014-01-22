FactoryGirl.define do
  factory :user do
    email                  "user@example.com"
    password               "password"
    password_confirmation  "password"
    admin true
  end
  factory :reg_user, class: User do
    email                  "user@nonadminexample.com"
    password               "password"
    password_confirmation  "password"
    admin false
  end
end
