class FormsController < ApplicationController
  
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_destroy!, only: [:edit, :update, :destroy]
  
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
  
  def edit
    @form = Form.find(params[:id])
  end
  
  def update
    @form = Form.find(params[:id])
    if @form.update_attributes(form_params)
      redirect_to @form, notice: 'Form was successfully updated.'
    else
      flash[:error] = @form.errors.full_messages.to_sentence
      render :edit
    end
  end
  
  def fill
    @filling = Filling.new(filling_params)
    @filling.form.questions.each do |question|
      @answer = @filling.answers.build
      @answer.category = question.category
      @answer.question_id = question.id
      if question.category == "text"
        @answer.content = params[question.id.to_s]
      elsif question.category == "number"
        @answer.content = params[question.id.to_s]
      elsif question.category == "date"
        @answer.date = params[question.id.to_s]
      elsif question.category == "multiple"
        @pick = @answer.picks.build
        @pick.choice_id = params[question.id.to_s]
        #unless  @pick.save
        #  flash[:error] = @pick.errors.full_messages.to_sentence
        #  raise ActiveRecord::Rollback
        #end
      elsif question.category == 'checkbox' || question.category == 'denture'
        if params[question.id.to_s]
          params[question.id.to_s].each do |choice_id|
            @pick = @answer.picks.build
            @pick.choice_id = choice_id
          end
        end
      elsif question.category == "dropdown"
        @pick = @answer.picks.build
        @pick.choice_id = params[question.id.to_s]
      end
      #unless  @answer.save
      #    flash[:error] = @answer.errors.full_messages.to_sentence
      #    raise ActiveRecord::Rollback
      #  end
    end
    if @filling.save
      redirect_to @filling, notice: 'Form was successfully filled.'
    else
      flash[:error] = @filling.errors.full_messages.to_sentence
      #flash[:error] = "The form contains #{@filling.errors.count} errors and could not be saved."
      render :show
    end
  end

  def edit_fill
    @filling = Filling.find(params[:id])
    @filling.answers.each do |answer|
      answer.destroy
    end
    @filling.form.questions.each do |question|
      @answer = @filling.answers.build
      @answer.category = question.category
      @answer.question_id = question.id
      if question.category == "text"
        @answer.content = params[question.id.to_s]
      elsif question.category == "number"
        @answer.content = params[question.id.to_s]
      elsif question.category == "date"
        @answer.date = params[question.id.to_s]
      elsif question.category == "multiple"
        @pick = @answer.picks.build
        @pick.choice_id = params[question.id.to_s]
        #unless  @pick.save
        #  flash[:error] = @pick.errors.full_messages.to_sentence
        #  raise ActiveRecord::Rollback
        #end
      elsif question.category == "checkbox" || question.category == 'denture'
        if params[question.id.to_s]
          params[question.id.to_s].each do |choice_id|
            @pick = @answer.picks.build
            @pick.choice_id = choice_id
          end
        end
      elsif question.category == "dropdown"
        @pick = @answer.picks.build
        @pick.choice_id = params[question.id.to_s]
      end
      #unless  @answer.save
      #    flash[:error] = @answer.errors.full_messages.to_sentence
      #    raise ActiveRecord::Rollback
      #  end
    end
    if @filling.save
      redirect_to @filling, notice: 'Filling was successfully edited.'
    else
      flash[:error] = @filling.errors.full_messages.to_sentence
      render :show
    end
  end


  def stats
    @form = Form.find(params[:id])
  end


  def index
    if params[:query]
      @forms = Form.where("title LIKE \'%#{params[:query]}%\'").paginate(:page => params[:f_page], :per_page => 10)
      @my_forms = current_user.forms.where("title LIKE \'%#{params[:query]}%\'").paginate(:page => params[:mf_page], :per_page => 10) if current_user
    else  
      @forms = Form.paginate(:page => params[:f_page], :per_page => 10)
      @my_forms = current_user.forms.paginate(:page => params[:mf_page], :per_page => 10)  if current_user
    end
  end
  
  def show
    @form = Form.find(params[:id])
    @filling = @form.fillings.new
  end
  
  def destroy
    Form.find(params[:id]).destroy
    redirect_to forms_path, :flash => { :success => "Form destroyed." }
  end
  
  private
  
  def form_params
    params.require(:form).permit(:user_id, :title, questions_attributes: [:id, :description, :category, :_destroy, choices_attributes: [:id, :content, :_destroy]])
  end
  
  def filling_params
    params.require(:filling).permit(:form_id, answers_attributes: [:id, :content, :date, :category, :question_id, :_destroy, picks_attributes: [:id, :choice_id, :_destroy]])
  end
  
end
