class OutputController < ApplicationController
    
    def index
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = ''
        @output_nav_class = 'active'
    end
end