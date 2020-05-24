class Account < ApplicationRecord
  belongs_to :client
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

end
