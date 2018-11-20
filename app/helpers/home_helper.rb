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
            return "Currently signed in as: " + current_user.email
        else
            return ""
        end
    end
end