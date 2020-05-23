require 'rails_helper'

RSpec.describe "accounts/show", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      num_account: "Num Account",
      num_branch: "Num Branch",
      balance: "9.99",
      inative: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Num Account/)
    expect(rendered).to match(/Num Branch/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/false/)
  end
end
