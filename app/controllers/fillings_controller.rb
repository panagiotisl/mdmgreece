class FillingsController < ApplicationController

  def index
    @fillings = Filling.all
  end

  def form_index
    @form = Form.find(params[:id])
    @fillings = @form.fillings.order(:serial)
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
