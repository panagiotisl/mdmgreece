class UsersController < ApplicationController
  
  before_action :authenticate_admin!

  def index
    @users = User.where(admin: false).reorder("email ASC").paginate(page: params[:page], :per_page => 10)
  end
  
  def index_inactive
    @users = User.where(approved: false).reorder("email ASC").paginate(page: params[:page], :per_page => 10)
  end
  
  def enable
    @user = User.find(params[:id])
    @user.toggle!(:approved)
    respond_to do |format|
      flash[:success] = "User with #{@user.email} has been approved"
      format.html { redirect_to inactive_path }
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to :back, notice: "User deleted"
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
end
