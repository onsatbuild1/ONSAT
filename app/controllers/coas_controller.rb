class CoasController < ApplicationController
    def coa_params
        params.require(:coa).permit(:coa_index, :description)
    end
    
    def show
        id = params[:id] # retrieve question ID from URI route
        @coa = Coa.find(id) # look up question by unique ID
    # will render app/views/question/show.<extension> by default
        @self = Company.find( @coa.self_id)
        @companies =@self.sub_contractors
        length = @coa.companies.length
        number = 1.0
        @coa.companies.each do |company|
            if(!company.coa_weights.find_by(coa_id: @coa.id).weight)
                
            else
                number=number-company.coa_weights.find_by(coa_id: @coa.id).weight
                length =length-1
            end
        end
        @coa.companies.each do |company|
            if(!company.coa_weights.find_by(coa_id: @coa.id).weight)
                company.coa_weights.find_by(coa_id: @coa.id).update(weight: number/length)
            end
        end
    end
    
    
    def index
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = ''
        @output_nav_class = ''
        @coa_nav_class = 'active'
        
        @self = Company.find_by(name: "Good Company")
        @self.sub_contractors.clear
        @self.sub_contractors << Company.find_by(name: "sub Good Company1")
        @self.sub_contractors << Company.find_by(name: "sub Good Company2")
        
        @coas =@self.self_coas
        @companies = Company.all
        
    end
    
    
    def new
        @self = Company.find_by(name: "Good Company")
    #   default: render 'new' template
    end
    
    def create
        if Coa.find_by(coa_index:coa_params[:coa_index], self_id: params[:self_id])
            flash[:notice] = "!Duplicate Index: #{coa_params[:coa_index]} was not created."
            redirect_to coas_path
        else
            @coa = Coa.create!(coa_params)
            @coa.update!(self_id: params[:self_id])
            @coa.companies << Company.find(params[:self_id])
            flash[:notice] = "#{@coa.coa_index} was successfully created."
            redirect_to coas_path
        end
    end
    
    def destroy
        @coa = Coa.find(params[:id])
        @coa.destroy
        flash[:notice] = "Coa '#{@coa.coa_index}' deleted."
        redirect_to coas_path
    end
    
    def update
        @coa = Coa.find params[:id]
        @coa.companies.clear 
        flash[:notice] = "Course of Action #{@coa.coa_index} was successfully updated."
        if(params[:companies])
            params[:companies].each do |company|
                @coa.companies << Company.find(company[0])
                if !params[:weights].nil?
                    Company.find(company[0]).coa_weights.find_by(coa_id: @coa.id).update(weight: params[:weights][company[0].to_str()])
                end
            end
        end
        redirect_to coa_path(@coa)
    end
end
