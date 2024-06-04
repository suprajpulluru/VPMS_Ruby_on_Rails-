class SessionsController < ApplicationController
    def new    
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id]=user.id
            flash[:notice] = "Logged in successfully"
            redirect_to root_path  
        else
            flash[:alert]="There was something wrong with details"
            redirect_to root_path
        end
    end

    def destroy
        session[:user_id]=nil
        flash[:notice]="Log out successful"
        redirect_to root_path
    end
end