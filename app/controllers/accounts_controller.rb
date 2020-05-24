class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
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
    # {day_resume: [{type: 'saque', value:'1230.00', date: '05/11/2020'},
    #               {type: 'saque', value:'1230.00', date: '05/11/2020'}],
    #  balance: "2220.00"}
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
