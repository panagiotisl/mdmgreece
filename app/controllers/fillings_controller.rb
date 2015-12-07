class FillingsController < ApplicationController

  before_action :authenticate_user!, only: [:form_index, :index, :show, :new, :create, :edit, :update, :destroy]
  before_action :authenticate_destroy!, only: [:edit, :update, :destroy]

  def index
    @fillings = Filling.all
  end

  def form_index
    @form = Form.find(params[:id])
    @fillings = @form.fillings.order(:serial)
    respond_to do |format|
      format.html
      format.csv { send_data @fillings.to_csv }
      format.xls
    end
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

  def destroy
    @filling = Filling.find(params[:id])
    @form = @filling.form
    @filling.destroy
    redirect_to fillings_index_path(:id => @form.id), :flash => {:success => "Filling removed."}
  end


end
