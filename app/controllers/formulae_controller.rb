class FormulaeController < ApplicationController
    
    def index
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = 'active'
        @output_nav_class = ''
        
        @categories = Category.all
        @categories =@categories.sort { |a,b| a.description <=> b.description }
    end
end