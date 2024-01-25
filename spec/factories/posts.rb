FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post Title #{n}" }
    association :author, factory: :user
    created_at { Time.current }
    comments_counter { 0 }
    likes_counter { 0 }
  end
end
