class Account < ApplicationRecord
  belongs_to :client
  has_many :account_movements
  after_create :insert_movement

  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :sorted_by,
          :search_query
      ]
  )

  scope :sorted_by, lambda{|sort_option = ' '|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    order(created_at: direction)
  }
  scope :search_query, lambda{|query = ' '|
    where('num_account = ? or num_branch = ?', query, query)
  }


  def insert_movement
    self.account_movements.new(operation: 1, dt_movement: Date.today, value: self.balance).save
  end

  def withdraw_value value
    value = value.to_f
    if self.balance - value >= 0
      self.balance -= value
      ActiveRecord::Base.transaction do
        if self.save
          return self.account_movements.new(operation: 2, dt_movement: Date.today, value: value).save
        end
      end
    else
      false
    end
    false
  end

  def deposit_value value
    value = value.to_f
    self.balance += value
    ActiveRecord::Base.transaction do
      if self.save
        return self.account_movements.new(operation: 1, dt_movement: Date.today, value: value).save
      end
    end
    false
  end

  def transfer_value account_to_transfer, value
    value = value.to_f
    ## verifica se a data atual esta em um dia da semana
    ## verifica o valor a taxa com base no harario
    tx = Date.today.on_weekday? && (Time.parse('9am')..Time.parse('18pm')).cover?(Time.now) ? 5.00 : 7.00
    value += 10.00 if value > 1000.00 ## adicional de 10 reais se o valor for maior que 1000
    value += tx

    if self.balance - value >= 0
      # criando movimentação para o o usuario de destino da transferencia
      account_to_transfer.balance += value
      ActiveRecord::Base.transaction do
        if account_to_transfer.save
          if account_to_transfer.account_movements.new(operation: 3, dt_movement: Date.today, value: value).save
            # criando movimentação para a conta do usuario
            self.balance -= value
            if self.save
              return self.account_movements.new(operation: 4, dt_movement: Date.today, value: value).save
            end
          end
        end
      end
    else
      false
    end
    false
  end


  private
  validates :num_account, uniqueness: true
  validates :num_branch, uniqueness: true

end
