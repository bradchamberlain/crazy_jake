class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_user, only: [:show, :update, :edit, :destroy]
  before_filter :set_admin

  def index
    @users = current_user.admin? ? User.all : current_user.master_user? ? User.where(customer_id: current_user.customer.id) : [current_user]
  end

  def new
    @user = User.new
  end

  def create
    if current_user.admin? or current_user.master_user?
      @user = User.new(user_params)
      if !current_user.admin?
        @user.customer = current_user.customer
      end
      @user.sign_in_count = 0
      respond_to do |format|
        if @user.save
          format.html { redirect_to users_path, notice: "#{@user.name} was successfully created." }
          format.json { render action: 'show', status: :created, location: @user }
        else
          format.html { render action: 'new' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url, notice: "You don't have permission to make that change."
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "#{@user.name} was updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: "#{@user.name} was deleted."}
      format.json { head :no_content }
    end
  end


  private

  def user_params
    if params[:user] and params[:user][:password].blank?
      params[:user].delete :password
    end
    params.require(:user).permit([:email, :customer_id, :admin, :name, :master_user, :password])
  end

  def set_user
    @user = User.find(params[:id])
  end

end