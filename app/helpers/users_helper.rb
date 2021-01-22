module UsersHelper
    def verified
        !current_user.nil?
    end
end
