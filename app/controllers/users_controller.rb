class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_user, only: [:show, :update, :edit, :destroy]

  def index
    @users = current_user.admin? ? User.all : nil
  end

  def new
    @user = User.new if current_user.admin?
  end

  def create
    @user = User.new(user_params) if current_user.admin?
    @user.password = "password"
    @user.sign_in_count = 0
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: "#{@user.email} was successfully created." }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "#{@user.email} was updated." }
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
      format.html { redirect_to users_path, notice: "#{@user.email} was deleted."}
      format.json { head :no_content }
    end
  end


  private

  def user_params
    params.require(:user).permit([:email, :customer_id, :admin])
  end

  def set_user
    @user = User.find(params[:id]) if current_user.admin?
  end

end