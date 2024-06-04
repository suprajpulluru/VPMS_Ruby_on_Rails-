class UsersController < ApplicationController
    before_action :require_same_user, only: [:show, :index, :edit, :active, :history]
    def show
        @user = User.find(params[:id])
    end

    def index

    end

    def new 
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            # Tell the UserMailer to send a welcome email after save
            UserMailer.with(user: @user).welcome_email.deliver_later

            session[:user_id]=@user.id
            flash[:notice] = "You are successfully signed up #{@user.username}"
            redirect_to root_path  
        else
            render 'new'
            # redirect_to signup_path
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "Your account information is successfully updated"
            redirect_to user_path(@user)  
        else
            render 'edit'
        end
    end

    def history
        @user = User.find(params[:id])
        @bills = Bill.where(user_id: @user.id).where.not(checkout_time: nil)
    end

    def active
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :DOB, :avatar, :password)
    end
    def require_same_user
        if !logged_in? || current_user != User.find(params[:id])   
            flash[:alert] = "You are not allowed to do this action"
            redirect_to root_path
        end
    end
end 