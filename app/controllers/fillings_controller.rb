class FillingsController < ApplicationController

  def index
    @fillings = Fillings.all
  end

  def show
    @filling = Filling.find(params[:id])
    @show = TRUE
  end

  def edit
    @filling = Filling.find(params[:id])
    @examination = @filling.examinations.build
    @show = FALSE
  end


end
