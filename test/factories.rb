FactoryBot.define do
  factory :user do
    name "Zeus"
    email { Faker::Internet.unique.email }
    password "password"
    password_confirmation "password"
  end

  factory :post do
    body "raeda in fossa est."
    user
  end
end