class OutputController < ApplicationController
    
    CompanyScores = Struct.new(:score, :category_scores, :subcat_scores, :question_scores)
    
    
    
    def index
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = ''
        @output_nav_class = 'active'
        
        @companies = Company.all
        @categories = Category.all
        
        @company_scores = calc_score()
        
    end
    
    def calc_score
        all_scores = Hash.new
        company_scores = Hash.new
        #@companies.each_with_index do |company, index|
        
        #    @answers = Answer.where(company_id: company.id).where(subcategory_id:)
        #    @answers.each do |answer|
        #        company_scores[] += answer
        #    end
        #end
        return all_scores
    end
end