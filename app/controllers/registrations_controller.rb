class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  def new
    super
  end

  def create
    # add custom create logic here
    super
  end

  def update
    super
  end
end 
