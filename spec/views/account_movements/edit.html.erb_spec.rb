require 'rails_helper'

RSpec.describe "account_movements/edit", type: :view do
  before(:each) do
    @account_movement = assign(:account_movement, AccountMovement.create!(
      operation: 1,
      value: "9.99"
    ))
  end

  it "renders the edit account_movement form" do
    render

    assert_select "form[action=?][method=?]", account_movement_path(@account_movement), "post" do

      assert_select "input[name=?]", "account_movement[operation]"

      assert_select "input[name=?]", "account_movement[value]"
    end
  end
end
