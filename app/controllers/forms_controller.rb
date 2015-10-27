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
    if @form.fillings.count > 0
      flash[:error] = 'The form has already been filled and cannot be edited.'
      redirect_to request.referer
    end
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
      @examination = @filling.examinations.build
      render :show
    end
  end

  def edit_fill
    @filling = Filling.find(params[:id])
    @filling.update(filling_params)
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
      @examination = @filling.examinations.build
      render :show
    end
  end


  def stats

    @form = Form.find(params[:id])
    select = "SELECT count(*) AS countall"
    if params["question"].nil? or params["question"] == ""
      where = "WHERE e.filling_id = f.id AND form_id = #{params[:id]}"
      from = "FROM examinations e, fillings f"
    else
      where = "WHERE e.filling_id = f.id AND f.id = a.filling_id AND form_id = #{params[:id]}"
      from = "FROM examinations e, fillings f, answers a"
    end


    groupby = "GROUP BY"
    if params[:area] == "on"
      select += ", area"
      groupby += "#{groupby.length==8 ? ' ' : ', '}area"
    end
    if params[:date] == "on"
      if params[:from] != ""
        where += " AND date >= '#{params[:from]}'"
      end
      if params[:to] != ""
        where += " AND date <= '#{params[:to]}'"
      end
    end
    if params[:program] == "on"
      select += ", program"
      groupby += "#{groupby.length==8 ? ' ' : ', '}program"
    end
    if params[:doctor] == "on"
      select += ", doctor"
      groupby += "#{groupby.length==8 ? ' ' : ', '}doctor"
    end
    question = 0
    unless params["question"].nil? or params["question"] == ""
      where += " AND a.question_id = #{params["question"]}"
      select += ", a.content AS question"
      groupby += "#{groupby.length==8 ? ' ' : ', '}a.content"
    end
    @examinations = Examination.find_by_sql("#{select} #{from} #{where} #{groupby.length==8 ? "" : groupby}")
    @hash = {}
    @examinations.each do |e|
      hash = params["question"].nil? ? "" : "#{e.attributes["question"]}"
      hash += "#{params[:area]=="on" ? (hash.length>0 ? "-" : "") + e.area : ""}"
      hash +="#{params[:doctor]=="on" ? (hash.length>0 ? "-" : "") + e.doctor : ""}"
      hash +="#{params[:program]=="on" ? (hash.length>0 ? "-" : "") + e.program : ""}"
      @hash[hash] = e.countall
    end

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
    @examination = @filling.examinations.build
  end
  
  def destroy
    Form.find(params[:id]).destroy
    redirect_to forms_path, :flash => {:success => 'Form destroyed.'}
  end

  def autocomplete_filling_area
    render json: Filling.select('DISTINCT area as value').where('LOWER(area) like LOWER(?)', "%#{params[:term]}%")
  end

  def autocomplete_examination_doctor
    render json: Examination.select('DISTINCT doctor as value').where('LOWER(doctor) like LOWER(?)', "%#{params[:term]}%")
  end

  def autocomplete_examination_program
    render json: Examination.select('DISTINCT program as value').where('LOWER(program) like LOWER(?)', "%#{params[:term]}%")
  end

  private

  def form_params
    params.require(:form).permit(:user_id, :title, :serial_enabled, :area_enabled, :date_enabled, :content_enabled, :doctor_enabled, :program_enabled, questions_attributes: [:id, :description, :category, :_destroy, choices_attributes: [:id, :content, :_destroy]])
  end
  
  def filling_params
    params.require(:filling).permit(:form_id, :serial, :area, examinations_attributes: [:id, :content, :date, :doctor, :program], answers_attributes: [:id, :content, :date, :category, :question_id, :_destroy, picks_attributes: [:id, :choice_id, :_destroy]])
  end
  
end
