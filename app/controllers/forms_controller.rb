class FormsController < ApplicationController

  def new
    @form = Form.new
  end

  def create
    @form = current_user.forms.create(form_params)
    if @form.save
      redirect_to @form, notice: 'Form was successfully created.'
    else
      flash[:error] = @form.errors.full_messages.to_sentence
      render :new
    end
  end

  def fill
    @filling = Filling.create(filling_params)
    if @filling.save
      redirect_to @filling, notice: 'Form was successfully filled.'
    else
      flash[:error] = @filling.errors.full_messages.to_sentence
      @form = @filling.form
      render :show
    end
  end

  def index
    @forms = current_user.forms
  end

  def show
    @form = Form.find(params[:id])
    @filling = Filling.new
  end

  private

    def form_params
      params.require(:form).permit(:user_id, :title, questions_attributes: [:id, :description, :category, :_destroy, choices_attributes: [:id, :content, :_destroy]])
    end
  
    def filling_params
      params.require(:filling).permit(:form_id, answers_attributes: [:id, :content, :category, :question_id, :_destroy, picks_attributes: [:id, :choice_id, :_destroy]])
    end

end
