FactoryBot.define do
  factory :account do
    num_account {rand(1_000_000).to_s }
    num_branch {rand(1_000_000).to_s}
    balance {rand(200.0...100000.99)}
    inative {Faker::Boolean.boolean}
    client

    trait :inative do
      inative { false }
    end
    #
    # after(:build) do |account, evaluator|
    #   create(:account_movement, account: account, value: evaluator.balance, operation: 1)
    # end
  end

end