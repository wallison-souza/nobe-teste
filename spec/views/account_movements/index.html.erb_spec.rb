require 'rails_helper'

RSpec.describe "account_movements/index", type: :view do
  before(:each) do
    assign(:account_movements, [
      AccountMovement.create!(
        operation: 2,
        value: "9.99"
      ),
      AccountMovement.create!(
        operation: 2,
        value: "9.99"
      )
    ])
  end

  it "renders a list of account_movements" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
  end
end
