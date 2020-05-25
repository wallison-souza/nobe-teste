FactoryBot.define do
  factory :client do
    email {"#{Faker::Internet.unique.email}_#{rand(2**8)}"}
    password {Faker::Internet.password}
  end

end