module HomeHelper
    def resource_name
        :user
    end

    def resource
        @resource ||= User.new
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end
    
    def renderCurrentUser
        if current_user
            tempstr = "Currently signed in as: " + current_user.email
            #tempstr += " | Company: " + current_user.company_id.to_s
            if (current_user.company_id)
                tempstr += " | Company: " + Company.find(current_user.company_id).name
            else
                tempstr += " | No company (It is possible this is an error)"
            end
            if (current_user.role)
                tempstr += " | Role: " + current_user.role
            else
                tempstr += " | Role: No Role (It is possible this is an error)"
            end
            #tempstr += current_user.to_s
            return tempstr
        else
            return ""
        end
    end
end