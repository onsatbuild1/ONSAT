class OutputController < ApplicationController
    
    CompanyScores = Struct.new(:score, :category_scores, :subcat_scores, :question_scores)
    
    
    
    def index
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = ''
        @output_nav_class = 'active'
        
        @companies = Company.all
        @categories = Category.all
        @answers = Answer.all
        @scales = Scale.all
        
        @company_scores = Hash.new
        @subcat_answers = []
        
        calc_score()
    end
    
    def calc_score
        
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
                        question_answer = @answers.find_by(company_id: company.id, question_id: question.id)
                        @subcat_answers << question_answer
                        @company_scores["#{company.id}question#{question.id}"] = @scales.find_by(level: question_answer.level).score

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
                    
                    @company_scores["#{company.id}cat#{category.id}"] += @company_scores["#{company.id}subcat#{subcat.id}"]
                end
                
                if category.subcategories.size() != 0
                    @company_scores["#{company.id}cat#{category.id}"] = (@company_scores["#{company.id}cat#{category.id}"] / category.subcategories.size()).round(3)
                end
                
                if @company_scores["#{company.id}Val"]
                    @company_scores["#{company.id}Val"] = @company_scores["#{company.id}catVal#{category.id}"]
                end

                @company_scores["#{company.id}"] += @company_scores["#{company.id}cat#{category.id}"]
            end
            
            
            if @categories.size() != 0
                @company_scores["#{company.id}"] = (@company_scores["#{company.id}"] / @categories.size()).round(3)
            end
        end
        
        
        
    end
end