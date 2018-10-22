class QuestionsController < ApplicationController
  
  def question_params
    params.require(:question).permit(:keyword, :index, :weight, :description)
  end

  def show
    id = params[:id] # retrieve question ID from URI route
    @question = Question.find(id) # look up question by unique ID
    # will render app/views/question/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'keyword'
      ordering,@keyword_header = {:keyword => :asc}, 'hilite'
    when 'weight'
      ordering,@weight_header = {:weight => :desc}, 'hilite'
    when 'answer'
      ordering,@answer_header = {:answer => :desc}, 'hilite'
    end
    #@all_ratings = Question.all_ratings
    #@selected_ratings = params[:ratings] || session[:ratings] || {}
    
    #if @selected_ratings == {}
    #  @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    #end
    
    
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    
    @questions = Question.order(ordering)#(rating: @selected_ratings.keys).order(ordering)
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

end
