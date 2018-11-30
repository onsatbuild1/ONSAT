class CoasController < ApplicationController
    def coa_params
        params.require(:coa).permit(:coa_index, :description)
    end
    
    def show
        id = params[:id] # retrieve question ID from URI route
        @coa = Coa.find(id) # look up question by unique ID
    # will render app/views/question/show.<extension> by default
        @companies =Company.all()
    end
    
    
    def index
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = ''
        @output_nav_class = 'active'
        
        @coas =Coa.all
        @companies = Company.all
        
    end
    
    
    def new
    #   default: render 'new' template
    end
    
    def create
        if Coa.find_by(coa_index:coa_params[:coa_index])
            flash[:notice] = "#{coa_params[:coa_index]} was not created."
            redirect_to coas_path
        else
            @coa = Coa.create!(coa_params)
            flash[:notice] = "#{@coa.coa_index} was successfully created."
            redirect_to coas_path
        end
    end
    
    def destroy
        @coa = Coa.find(params[:id])
        @coa.destroy
        flash[:notice] = "Coa '#{@coa.index}' deleted."
        redirect_to coas_path
    end
    
    def update
        @coa = Coa.find params[:id]
        @coa.companies.clear 
        flash[:notice] = "Scenario #{@coa.coa_index} was successfully updated."
        if(params[:companies])
            params[:companies].each do |company|
                @coa.companies << Company.find(company[0])
            end
        end
        redirect_to coa_path(@coa)
    end
end
