class UserMailer < ApplicationMailer
  default from: 'shyamshinde555@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Eshopper,'+@user.firstname.capitalize)
  end
end
