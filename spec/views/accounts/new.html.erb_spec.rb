require 'rails_helper'

RSpec.describe "accounts/new", type: :view do
  before(:each) do
    assign(:account, Account.new(
      num_account: "MyString",
      num_branch: "MyString",
      balance: "9.99",
      inative: false
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input[name=?]", "account[num_account]"

      assert_select "input[name=?]", "account[num_branch]"

      assert_select "input[name=?]", "account[balance]"

      assert_select "input[name=?]", "account[inative]"
    end
  end
end
