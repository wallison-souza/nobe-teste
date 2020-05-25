class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy,:withdraw, :deposit, :transfer]
  include FullErrorMessage
  # GET /accounts
  # GET /accounts.json
  def index
    @filterrific = initialize_filterrific(
        Account.where(client_id: current_client.id),
        params[:filterrific]
    ) or return
    @accounts = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js { render 'accounts/js/index' }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show

  end

  # GET /accounts/new
  def new
    @account = Account.new
    @account.client_id = params[:client]
    respond_to do |format|
      format.html
      format.json { render 'accounts/form' }
    end
  end

  # GET /accounts/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json { render 'accounts/form' }
    end
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, flash:{success: 'Conta criada com sucesso!' } }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: FullErrorMessage.error_message(@account), status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, flash:{success: 'Conta foi atualizada com sucesso!' } }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: FullErrorMessage.error_message(@account), status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.inative = true
    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_url, flash:{success: 'Sua conta foi encerrada com sucesso.'} }
        format.json { head :no_content }
      else
        format.html { redirect_to accounts_url, flash:{danger: 'Houve um erro no encerramento da sua conta.'} }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end

  end

  def withdraw
    respond_to do |format|
      if current_client.valid_password?(params[:client][:password])
        if @account.withdraw_value(params[:value])
          format.html { redirect_to index_account_movements_path(@account), flash: {success: 'Saque realizado com sucesso!'} }
          format.json { render json: 'Saque realizado com sucesso!', status: :unprocessable_entity }
        else
          format.html { redirect_to index_account_movements_path(@account), flash: {danger: 'Saldo insuficiente'} }
          format.json { render json: 'Saldo insuficiente', status: :unprocessable_entity }
        end
      else
        format.html { redirect_to index_account_movements_path(@account), flash: {danger: 'Senha invalida'} }
        format.json { render json: 'Senha invalida.', status: :unprocessable_entity }
      end
    end
  end

  def deposit
    respond_to do |format|
      if @account.deposit_value(params[:value])
        format.html { redirect_to index_account_movements_path(@account), flash: {success: 'Deposito realizado com sucesso!'} }
        format.json { render json: 'Deposito realizado com sucesso!', status: :unprocessable_entity }
      else
        format.html { redirect_to index_account_movements_path(@account), flash: {danger: 'Saldo insuficiente'} }
        format.json { render json: 'Saldo insuficiente', status: :unprocessable_entity }
      end
    end
  end

  def transfer
    respond_to do |format|
      if current_client.valid_password?(params[:client][:password])
        if account_to_transfer = Account.find_by(num_branch: params[:num_branch], num_account: params[:num_account])
          if !account_to_transfer.inative
            if @account.transfer_value(account_to_transfer, params[:value])
              format.html { redirect_to index_account_movements_path(@account), flash: {success: 'Transferencia realizada com sucesso!'} }
              format.json { render json: 'Transferencia realizada com sucesso!', status: :unprocessable_entity }
            else
              format.html { redirect_to index_account_movements_path(@account), flash: {danger: 'Saldo insuficiente'} }
              format.json { render json: 'Saldo insuficiente', status: :unprocessable_entity }
            end
          else
            format.html { redirect_to index_account_movements_path(@account),
                                      flash: {danger: 'A conta para qual você está tentando transferir foi encerrada!'} }
            format.json { render json: 'A conta para qual você está tentando transferir foi encerrada!', status: :unprocessable_entity }
          end
        else
          format.html { redirect_to index_account_movements_path(@account), flash: {danger: 'Não foi encontrada a conta e agência'} }
          format.json { render json: 'Não foi encontrada a conta e agência', status: :unprocessable_entity }
        end
      else
        format.html { redirect_to index_account_movements_path(@account), flash: {danger: 'Senha invalida'} }
        format.json { render json: 'Senha invalida.', status: :unprocessable_entity }
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:num_account, :num_branch, :balance,:client_id, :inative)
  end
end
