class UsersController < ApplicationController
    include  AssosHelper
    before_action :logged_in_user, only: [:show]
    def show
        @user = User.find(params[:id])
    end
    
    def new
        @user = User.new
    end
    
    def create
        if get_rna_asso_by_official_id(user_params["identifiant"]) === nil
            flash[:danger] = "Merci de vérifier votre identifiant officiel."
            redirect_to signup_url
            return
        end
        @user = User.new(user_params)
        if @user.save
            log_in @user
            flash[:success] = "Félicitation, vous êtes connectés"
            redirect_to @user
        else
          render 'new'
        end
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :email, :identifiant, :password, :password_confirmation)
    end
end
