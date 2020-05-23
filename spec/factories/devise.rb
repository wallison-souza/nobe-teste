FactoryBot.define do
  factory :client do
    id {1}
    email {"test@client.com"}
    password {"123456"}
    # Add additional fields as required via your User model
  end

end