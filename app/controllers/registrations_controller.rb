# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    c = Customer.create(customer_params)
    @user = User.new(user_params)
    if !c.persisted?
      respond_to do |format|
        format.html{ render action: 'new', notice: "#{c.name} cannot be created.  That customer may already exist."}
        format.json { render json: c.errors, status: :unprocessable_entity }
      end
      return
    end
    @user.master_user = true
    @user.customer = c
    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to users_path, notice: "#{@user.name}: You have successfully registered." }
        format.json { render action: 'show', status: :created, location: @user }
      else
        if c.persisted?
          c.destroy
        end
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    super
  end

  private

  def customer_params
    params.require(:customer).permit(:name)
  end

  def user_params
    params.require(:user).permit([:email, :customer_id, :name, :password])
  end
end