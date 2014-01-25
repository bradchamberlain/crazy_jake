class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_admin
    @admin = current_user.admin?
    @editable = (current_user.admin? or current_user.master_user?)
  end
end
