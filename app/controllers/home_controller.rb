class HomeController < ApplicationController
    
    def index
        @home_nav_class = 'active'
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = ''
        @output_nav_class = ''
    end
end