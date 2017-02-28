class UserMailer < ApplicationMailer
  default from: 'eshopper@admin.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    attachments.inline['logo.png'] = File.read('app/assets/images/home/logo.png')
    mail(to: @user.email, subject: 'Welcome to Eshopper')
  end
end
