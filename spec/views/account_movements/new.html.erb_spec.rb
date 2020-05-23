require 'rails_helper'

RSpec.describe "account_movements/new", type: :view do
  before(:each) do
    assign(:account_movement, AccountMovement.new(
      operation: 1,
      value: "9.99"
    ))
  end

  it "renders new account_movement form" do
    render

    assert_select "form[action=?][method=?]", account_movements_path, "post" do

      assert_select "input[name=?]", "account_movement[operation]"

      assert_select "input[name=?]", "account_movement[value]"
    end
  end
end
