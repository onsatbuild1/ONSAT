class ApplicationController < ActionController::Base
    protect_from_forgery
  
    def requireDecisionMaker
        if user_signed_in? and current_user.role != "Decision Maker"
            flash[:error] = "You do not have permission to access that"
            redirect_to '/home'
        elsif !user_signed_in?
            flash[:error] = "You are not logged in and cannot access that"
            redirect_to '/home'
        end
    end
    
    def requireCompRepOrValidator
        if user_signed_in? and current_user.role != "Company Representative" and current_user.role != "Validator"
            flash[:error] = "You do not have permission to access that"
            redirect_to '/home'
        elsif !user_signed_in?
            flash[:error] = "You are not logged in and cannot access that"
            redirect_to '/home'
        end 
    end
    
end
