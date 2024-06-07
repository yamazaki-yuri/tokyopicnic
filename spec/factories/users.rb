FactoryBot.define do
  factory :user do
    name { 'サンドイッチ' }
    sequence(:email) { |n| "tokyo_picnic#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
