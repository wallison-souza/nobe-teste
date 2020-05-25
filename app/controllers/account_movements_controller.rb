class AccountMovementsController < ApplicationController
  # GET /account_movements
  # GET /account_movements.json
  def index
    # [ [ [operation: 'saque', value:'1230.00', dt_movement: '05/11/2020'],
    #     [operation: 'saque', value:'1230.00', dt_movement: '05/11/2020'] ],
    #   [ [operation: 'saque', value:'1230.00', dt_movement: '05/12/2020'],
    #     [operation: 'saque', value:'1230.00', dt_movement: '05/12/2020'] ]
    @filterrific = initialize_filterrific(
        AccountMovement.where(account_id: params[:account]),
        params[:filterrific]
    ) or return
    @account_movements = @filterrific.find.page(params[:page]).per(6)
    # agrupando as datas iguais
    @account_movement_array =  @account_movements.chunk { |s| s.dt_movement}.map(&:last)
    @account = Account.find(params[:account])

    respond_to do |format|
      format.html
      format.js { render 'account_movements/js/index' }
    end

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{e.message}"
    redirect_to(reset_filterrific_url(format: :html)) && return

end



private
# Use callbacks to share common setup or constraints between actions.
def set_account_movement
  @account_movement = AccountMovement.find(params[:id])
end

# Only allow a list of trusted parameters through.
def account_movement_params
  params.require(:account_movement).permit(:dt_movement, :operation, :value, :account_id)
end
end
