class CoasController < ApplicationController
    before_action :requireDecisionMaker
    #requireDecisionMaker is defined in application_controller.rb
    
    def coa_params
        params.require(:coa).permit(:coa_index, :description)
    end

    def show
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = ''
        @output_nav_class = ''
        @coa_nav_class = 'active'
        id = params[:id] # retrieve question ID from URI route
        @coa = Coa.find(id) # look up question by unique ID
        # will render app/views/question/show.<extension> by default
        @self = Company.find( @coa.self_id)
        @coas =@self.self_coas
        @companies =@self.sub_contractors
        @length = @coa.companies.length
        @number = 1.0
        @coa.companies.each do |company|
            if(!company.coa_weights.find_by(coa_id: @coa.id).weight)
                
            else
                @number=@number-company.coa_weights.find_by(coa_id: @coa.id).weight
                @length =@length-1
            end
        end
        @coa.companies.each do |company|
            if(!company.coa_weights.find_by(coa_id: @coa.id).weight)
                company.coa_weights.find_by(coa_id: @coa.id).update(weight: (@number/@length).round(3))
            end
        end
    end

    def index
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = ''
        @output_nav_class = ''
        @coa_nav_class = 'active'
        
        @self = Company.find(current_user.company_id)
        @coas =@self.self_coas
        @companies = Company.all
    end
    
    
    def new
        @home_nav_class = ''
        @input_nav_class = '' # Input Tab
        @formulae_nav_class = ''
        @output_nav_class = ''
        @coa_nav_class = 'active'

        @self = Company.find(current_user.company_id)
        @coas =@self.self_coas
        #default: render 'new' template
       
    end
    
    def create
        if Coa.find_by(coa_index:coa_params[:coa_index], self_id: params[:self_id])
            flash[:notice] = "!Duplicate Index: #{coa_params[:coa_index]} was not created."
            redirect_to coas_path
        else
            @coa = Coa.create!(coa_params)
            @coa.update!(self_id: params[:self_id])
            @coa.companies << Company.find(params[:self_id])
            
            @length = @coa.companies.length
            @number = 1.0
            @coa.companies.each do |company|
                if(!company.coa_weights.find_by(coa_id: @coa.id).weight)
                
                else
                    @number=@number-company.coa_weights.find_by(coa_id: @coa.id).weight
                    @length =@length-1
                end
            end
            @coa.companies.each do |company|
                if(!company.coa_weights.find_by(coa_id: @coa.id).weight)
                    company.coa_weights.find_by(coa_id: @coa.id).update(weight: (@number/@length).round(3))
                end
            end
            
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
                if !params[:weights].nil?
                    if params[:weights][company[0].to_str()].to_f()>0
                        @coa.companies << Company.find(company[0])
                        Company.find(company[0]).coa_weights.find_by(coa_id: @coa.id).update(weight: params[:weights][company[0].to_str()])
                    end
                end
            end
        end

        @length = @coa.companies.length
        @number = 1.0
        @coa.companies.each do |company|
            if(!company.coa_weights.find_by(coa_id: @coa.id).weight)
                
            else
                @number=@number-company.coa_weights.find_by(coa_id: @coa.id).weight
                @length =@length-1
            end
        end
        @coa.companies.each do |company|
            if(!company.coa_weights.find_by(coa_id: @coa.id).weight)
                company.coa_weights.find_by(coa_id: @coa.id).update(weight: (@number/@length).round(3))
            end
        end
        redirect_to coa_path(@coa)
        
    end
end
