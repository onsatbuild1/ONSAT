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
    
    def getAllCompanies
        return (Company.all).inspect
    end
end