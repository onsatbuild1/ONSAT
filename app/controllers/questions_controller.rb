class QuestionsController < ApplicationController
  
  def question_params
    params.require(:question).permit(:keyword, :subcategory_id, :index, :weight, :description)
  end

  def show
    id = params[:id] # retrieve question ID from URI route
    @question = Question.find(id) # look up question by unique ID
    # will render app/views/question/show.<extension> by default
  end

  def index
    @home_nav_class = ''
    @input_nav_class = 'active' # Input Tab
    @formulae_nav_class = ''
    @output_nav_class = ''
    
    @subcategories = Subcategory.all
    
    sort = params[:sort] || session[:sort]
    case sort
    when 'keyword'
      ordering,@keyword_header = {:keyword => :asc}, 'hilite'
    when 'weight'
      ordering,@weight_header = {:weight => :desc}, 'hilite'
    end
    
    
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    
    #@subcategory_questions = {}
    #@subcategories.each do |q_cat|
      #@subcategory_questions[q_cat.id] = Question.where(subcategory_id: q_cat.id)
    #end
  end

  def new
    # default: render 'new' template
  end

  def create
    @question = Question.create!(question_params)
    flash[:notice] = "#{@question.description} was successfully created."
    redirect_to questions_path
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
    @question.update_attributes!(question_params)
    flash[:notice] = "#{@question.keyword} was successfully updated."
    redirect_to question_path(@question)
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "Question '#{@question.keyword}' deleted."
    redirect_to questions_path
  end
  
  def upload
      if params[:file].present?
          Question.upload(params[:file])
          redirect_to root_url, notice: "Upload Successful"
          else
          flash[:error] = "No File Chosen"
          redirect_to root_url
      end
  end

end 
