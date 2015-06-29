class FillingsController < ApplicationController

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
    Filling.find(params[:id]).destroy
    redirect_to fillings_index_path, :flash => {:success => "Filling removed."}
  end


end
