class UserMailer < ApplicationMailer
    # default from: 'notifications@example.com'
    
    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: "Welcome to VPMS Website")
    end
end