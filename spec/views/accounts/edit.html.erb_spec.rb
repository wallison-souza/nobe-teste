require 'rails_helper'

RSpec.describe "accounts/edit", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      num_account: "MyString",
      num_branch: "MyString",
      balance: "9.99",
      inative: false
    ))
  end

  it "renders the edit account form" do
    render

    assert_select "form[action=?][method=?]", account_path(@account), "post" do

      assert_select "input[name=?]", "account[num_account]"

      assert_select "input[name=?]", "account[num_branch]"

      assert_select "input[name=?]", "account[balance]"

      assert_select "input[name=?]", "account[inative]"
    end
  end
end
