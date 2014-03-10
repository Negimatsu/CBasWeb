class UserMailer < ActionMailer::Base
  default :from => "notifications@cbas.com"

  def welcome_email(user)
    @user = user
    @url  = "https://158.108.16.250:11111"
    mail(:to => user.email, :subject => "Welcome #{user.name} to My cBas Site ")
  end

  def try_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "send email By rails I try it" ,:cc =>"ong_dkrab@hotmail.com")
  end

  def weekly_mail(email)
    mail(:to => email, :subject => "tryIt" , cc:"ong_dkrab@hotmail.com")
  end

  def finished_work(work)
    @url =  "https://158.108.16.250:11111"
    @work = work
    @user = work.user
    mail(:to => work.user.email, :subject => "Your #{work.title} has finished")
  end


end