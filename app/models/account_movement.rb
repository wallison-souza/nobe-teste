class AccountMovement < ApplicationRecord
  belongs_to :account
  enum operations: {entrada: 1, saida: 2, transferencia_recebida: 3, transferencia_enviada: 4}
  filterrific(
      default_filter_params: { sorted_by: 'dt_movement_desc' },
      available_filters: [
          :sorted_by,
          :start_date,
          :end_date,
          :search_entry,
          :search_out,
          :search_all
      ]
  )

  # scope :previous_balance, lambda{|param = ' '|
  #   unless param.blank?
  #     select('SUM( case operation when 2 then -value
  #               else value
  #               end) AS previous_balance')
  #         .where('dt_movement <= ? ', param)
  #   end
  # }

  scope :sorted_by, lambda{|sort_option = ' '|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    order(dt_movement: direction)
  }
  scope :start_date, lambda{|param = ' '|
    where('created_at >= ? ', param)
  }
  scope :end_date, lambda{|param = ' '|
    where('created_at <= ? ', param)
  }
  scope :search_entry, lambda{|param = ' '|
    if param == 'true'
      where('operation = ? ', AccountMovement.operations[:entrada])
    end
  }
  scope :search_out, lambda{|param = ' '|
    if param == 'true'
      where('operation = ? ', AccountMovement.operations[:saida])
    end
  }
  scope :search_all, lambda{|param = ' '|
  }
end
