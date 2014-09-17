FactoryGirl.define do
  factory :user do
    name     "Santi Botta"
    email    "santibotta@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end