FactoryBot.define do
  factory :account_movement do
    dt_movement {Date.today}
    operation {Faker::Number.positive(from: 1, to: 3)}
    balance {rand(0.0...100000.99)}
    inative {Faker::Boolean.boolean}
    account
  end
end