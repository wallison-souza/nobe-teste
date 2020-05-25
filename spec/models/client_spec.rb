require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { build_stubbed(:client) }
  let(:account) { build_stubbed(:account, client: client) }
  context 'quando cliente com sua conta é criado:' do
    it "é válido se  o email e a senha estão presentes" do
      expect(client).to be_valid
    end
    it "é valido se o numero da conta e agencia estão presentes" do
      expect(account).to be_valid
    end

  end
end
