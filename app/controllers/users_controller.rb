class UsersController < ApplicationController

  before_action :authenticate_user!

  def index_inactive
    @users = User.where(approved: false).reorder("email ASC").paginate(page: params[:page], :per_page => 30)
  end

  def enable
    @user = User.find(params[:id])
    @user.toggle!(:approved)
    respond_to do |format|
      flash[:success] = "User with #{@user.email} has been approved"
      format.html { redirect_to inactive_path }
    end
  end

end
