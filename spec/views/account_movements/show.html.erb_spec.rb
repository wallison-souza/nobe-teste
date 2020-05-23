require 'rails_helper'

RSpec.describe "account_movements/show", type: :view do
  before(:each) do
    @account_movement = assign(:account_movement, AccountMovement.create!(
      operation: 2,
      value: "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
  end
end
