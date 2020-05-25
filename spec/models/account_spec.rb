require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:client) { create(:client) }
  let(:account) { create(:account, client: client) }

  it 'não é valido se não pertencer a um usuario' do
    account_without_client = build(:account, client: nil)
    expect(account_without_client).to_not be_valid
  end
  it 'é validado quando feito um deposito o saldo aumentar' do
    balance = account.balance
    expect(account.deposit_value(120)).to be_truthy
    expect(account.balance).to be > balance
  end
  it 'é valido quando feito um saque o saldo diminua' do
    balance = account.balance
    expect(account.withdraw_value(50)).to be_truthy
    expect(account.balance).to be < balance
  end
  it 'não é valido fazer um saque com saldo insuficiente' do
    account_1 = create(:account, client: client, balance:10)
    expect(account_1.withdraw_value(50)).to be_falsey
  end
  it 'é valido quando feito uma transferencia o saldo diminuia' do
    client_2 = create(:client)
    account_2 = create(:account, client: client_2)
    balance = account.balance
    expect(account.transfer_value(account_2, 50)).to be_truthy
    expect(account.balance).to be < balance
  end
  it 'não valido fazer uma transferencia com saldo insuficiente' do
    client_2 = create(:client)
    account_2 = create(:account, client: client_2)
    account_1 = create(:account, client: client, balance:10)
    expect(account_1.transfer_value(account_2, 50)).to be_falsey
  end
  it 'é valido quando feito uma transferencia o saldo para quem se transferiu aumente' do
    client_2 = create(:client)
    account_2 = create(:account, client: client_2)
    balance = account_2.balance
    account.transfer_value(account_2, 50)
    expect(account_2.balance).to be > balance
  end
  it 'é valido quando feito um deposito cria-se uma movimentação' do
    expect{ account.deposit_value(120) }.to change{ AccountMovement.count }.by(2)
  end
  it 'é valido quando feito um saque cria-se uma movimentação' do
    expect{ account.withdraw_value(119) }.to change{ AccountMovement.count }.by(2)
  end
  it 'é valido quando feito uma transferencia cria-se uma movimentação para quem transferiu' do
    client_2 = create(:client)
    account_2 = create(:account, client: client_2)
    expect{ account.transfer_value(account_2, 50) }.to change{ account.account_movements.count }.by(1)
  end
  it 'é valido quando feito uma transferencia cria-se uma movimentação para quem recebeu' do
    client_2 = create(:client)
    account_2 = create(:account, client: client_2)
    expect{ account.transfer_value(account_2, 50) }.to change{ account_2.account_movements.count }.by(1)
  end
  it 'é valido a transferencia com taxa de 7 reais se o dia estiver entre sabado e domingo' do
    allow(Date).to receive(:today).and_return Date.new(2020,5,30) ## cai num sabado
    client_2 = create(:client)
    account_2 = create(:account, client: client_2)
    account = create(:account, client: client, balance: 20)
    account.transfer_value(account_2, 5)
    expect(account.balance).to eq(20-5-7) #20 reais - 5 transferido - 7 taxa
  end
  it 'é valido a transferencia com taxa de 5 reais se o dia estiver entre segunda e sexta e dentro do horario entre 9am a 18pm' do
    allow(Date).to receive(:today).and_return Date.new(2020,5,27) ## cai numa quarta
    allow(Time).to receive(:now).and_return Time.parse('10am') ## setando hora
    client_2 = create(:client)
    account_2 = create(:account, client: client_2)
    account = create(:account, client: client, balance: 20)
    account.transfer_value(account_2, 5)
    expect(account.balance).to eq(20-5-5) #20 reais - 5 transferido - 7 taxa
  end
  it 'é valido a transferencia com taxa de 7 reais se o dia estiver entre segunda e sexta e fora do horario entre 9am a 18pm' do
    allow(Date).to receive(:today).and_return Date.new(2020,5,27) ## cai numa quarta
    allow(Time).to receive(:now).and_return Time.parse('19pm') ## setando hora
    client_2 = create(:client)
    account_2 = create(:account, client: client_2)
    account = create(:account, client: client, balance: 20)
    account.transfer_value(account_2, 5)
    expect(account.balance).to eq(20-5-7) #20 reais - 5 transferido - 7 taxa
  end
  it 'é valido a transferencia com valor adicional de taxa de 10 reais se o valor transferido for maior que 1000 reais' do
    allow(Date).to receive(:today).and_return Date.new(2020,5,27) ## cai numa quarta
    allow(Time).to receive(:now).and_return Time.parse('10am') ## setando hora
    client_2 = create(:client)
    account_2 = create(:account, client: client_2)
    account = create(:account, client: client, balance: 2000)
    account.transfer_value(account_2, 1000.50)
    expect(account.balance).to eq(2000-1000.50-5-10) #20 reais - 1000.50 transferido - 5 taxa - 10 de taxa adicional
  end

  it 'não é valido a transferencia que cobrar a taxa adicional de 10 reais quando o valor transferido for menor que 1000 reais' do
    allow(Date).to receive(:today).and_return Date.new(2020,5,27) ## cai numa quarta
    allow(Time).to receive(:now).and_return Time.parse('10am') ## setando hora
    client_2 = create(:client)
    account_2 = create(:account, client: client_2)
    account = create(:account, client: client, balance: 2000)
    account.transfer_value(account_2, 999.99)
    expect(account.balance).to_not eq(2000-999.99-5-10) #20 reais - 1000.50 transferido - 5 taxa - 10 de taxa adicional
  end

end
