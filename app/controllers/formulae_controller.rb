class FormulaeController < ApplicationController
    
    def index
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = 'active'
        @output_nav_class = ''
        
        @subcategories = Subcategory.all
    end
end