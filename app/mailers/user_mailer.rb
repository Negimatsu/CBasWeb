class UserMailer < ActionMailer::Base
  default :from => "notifications@example.com"

  def welcome_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site #{user.name}")
  end

  def try_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "send email By rails I try it" ,:cc =>"ong_dkrab@hotmail.com")
  end

  def weekly_mail(email)
    mail(:to => email, :subject => "tryIt" , cc:"ong_dkrab@hotmail.com")
  end

  def welcome_message(email)
    mail(:to => email, :subject => "tryIt" , cc:"ong_dkrab@hotmail.com")
  end


end