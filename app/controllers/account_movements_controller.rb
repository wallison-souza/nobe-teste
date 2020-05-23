class AccountMovementsController < ApplicationController
  before_action :set_account_movement, only: [:show, :edit, :update, :destroy]

  # GET /account_movements
  # GET /account_movements.json
  def index
    @account_movements = AccountMovement.all
  end

  # GET /account_movements/1
  # GET /account_movements/1.json
  def show
  end

  # GET /account_movements/new
  def new
    @account_movement = AccountMovement.new
  end

  # GET /account_movements/1/edit
  def edit
  end

  # POST /account_movements
  # POST /account_movements.json
  def create
    @account_movement = AccountMovement.new(account_movement_params)

    respond_to do |format|
      if @account_movement.save
        format.html { redirect_to @account_movement, notice: 'Account movement was successfully created.' }
        format.json { render :show, status: :created, location: @account_movement }
      else
        format.html { render :new }
        format.json { render json: @account_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_movements/1
  # PATCH/PUT /account_movements/1.json
  def update
    respond_to do |format|
      if @account_movement.update(account_movement_params)
        format.html { redirect_to @account_movement, notice: 'Account movement was successfully updated.' }
        format.json { render :show, status: :ok, location: @account_movement }
      else
        format.html { render :edit }
        format.json { render json: @account_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_movements/1
  # DELETE /account_movements/1.json
  def destroy
    @account_movement.destroy
    respond_to do |format|
      format.html { redirect_to account_movements_url, notice: 'Account movement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_movement
      @account_movement = AccountMovement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_movement_params
      params.require(:account_movement).permit(:dt_movement, :operation, :value)
    end
end
