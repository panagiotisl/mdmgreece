class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def authenticate_admin!
    redirect_to :back, notice: 'You dont have enough permissions to be here' unless current_user and current_user.admin
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  def authenticate_destroy!
    puts "PAOK"
    puts params[:id]
    redirect_to :back, notice: 'You dont have enough permissions to do that' unless current_user.admin or current_user.id == Form.find(params[:id]).user_id
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end


end
