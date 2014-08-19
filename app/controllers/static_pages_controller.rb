class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @my_forms = current_user.forms.paginate(:page => params[:mf_page], :per_page => 10)
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end

  def search
    @term = params[:term]
    @forms = Form.search @term, page: params[:forms_page], per_page: 25, fields: [{name: :word_start}]
  end

end
