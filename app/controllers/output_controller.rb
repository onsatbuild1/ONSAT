class OutputController < ApplicationController
    before_action :requireDecisionMaker
    #requireDecisionMaker is defined in application_controller.rb
    
    def show
        @current_coa = Coa.find(params[:id])
        @companies = @current_coa.companies
        @categories = Category.all
        @scales = Scale.all
        Company.eager_load(:answers)
        calc_company_score()
        
        render :partial => "companies"
    end
    
    def index
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = ''
        @output_nav_class = 'active'
        
        @coas = Coa.all
        
    end
    
    def calc_company_score
        
        
        
        @company_scores = Hash.new
        @subcat_answers = []
        
        @companies.each do |company|
            @company_scores["#{company.id}"] = 0
            @company_scores["#{company.id}Val"] = true
            
            @categories.each do |category|
                @company_scores["#{company.id}cat#{category.id}"] = 0
                @company_scores["#{company.id}catVal#{category.id}"] = true
                
                category.subcategories.each do |subcat|
                    @company_scores["#{company.id}subcat#{subcat.id}"] = 0
                    @company_scores["#{company.id}subcatVal#{subcat.id}"] = true
                    
                    #most inner loop...nasty stuff really...database needs to be better set up
                    subcat.questions.each do |question|
                        question_answer = company.answers.find_by(question_id: question.id)
                        @subcat_answers << question_answer
                        @company_scores["#{company.id}question#{question.id}"] = category.scales.find_by(level: question_answer.level).score

                        if @company_scores["#{company.id}subcatVal#{subcat.id}"]
                            @company_scores["#{company.id}subcatVal#{subcat.id}"] = question_answer.validated
                        end


                        #the adding for all the subcategory questions
                        valid = (@company_scores["#{company.id}subcatVal#{subcat.id}"] ? 1 : 0)
                        @company_scores["#{company.id}subcat#{subcat.id}"] += (@company_scores["#{company.id}question#{question.id}"] * valid)
                    end
                    
                    if subcat.questions.size() != 0
                        @company_scores["#{company.id}subcat#{subcat.id}"] = (@company_scores["#{company.id}subcat#{subcat.id}"] / subcat.questions.size()).round(3)
                    end
                    
                    if @company_scores["#{company.id}catVal#{category.id}"]
                        @company_scores["#{company.id}catVal#{category.id}"] = @company_scores["#{company.id}subcatVal#{subcat.id}"]
                    end
                    
                    #the adding for all the category subcategories
                    valid = (@company_scores["#{company.id}catVal#{category.id}"] ? 1 : 0)
                    @company_scores["#{company.id}cat#{category.id}"] += (@company_scores["#{company.id}subcat#{subcat.id}"] * valid)
                end
                
                if category.subcategories.size() != 0
                    @company_scores["#{company.id}cat#{category.id}"] = (@company_scores["#{company.id}cat#{category.id}"] / category.subcategories.size()).round(3)
                end
                
                if @company_scores["#{company.id}Val"]
                    @company_scores["#{company.id}Val"] = @company_scores["#{company.id}catVal#{category.id}"]
                end


                #the adding for all the company categories
                valid = (@company_scores["#{company.id}Val"] ? 1 : 0)
                @company_scores["#{company.id}"] += (@company_scores["#{company.id}cat#{category.id}"] * valid)
            end
            
            
            if @categories.size() != 0
                @company_scores["#{company.id}"] = (@company_scores["#{company.id}"] / @categories.size()).round(3)
            end
        end
        
        
        
    end
end