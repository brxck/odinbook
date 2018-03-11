FactoryBot.define do
  factory :user do
    name "Zeus"
    email { Faker::Internet.unique.email }
    password "password"
    password_confirmation "password"

    factory :user_with_posts do
      transient do
        posts_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end

  factory :post do
    body "raeda in fossa est."
    link "https://example.com"
    user
  end
end
