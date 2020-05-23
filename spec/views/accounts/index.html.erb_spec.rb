require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        num_account: "Num Account",
        num_branch: "Num Branch",
        balance: "9.99",
        inative: false
      ),
      Account.create!(
        num_account: "Num Account",
        num_branch: "Num Branch",
        balance: "9.99",
        inative: false
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", text: "Num Account".to_s, count: 2
    assert_select "tr>td", text: "Num Branch".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
