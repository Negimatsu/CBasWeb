class UserMailer < ActionMailer::Base
  default :from => "no-reply-notifications@cbas.com"


  def welcome_email(user)
    init_var
    @user = user
    mail(:to => user.email, :subject => "Welcome #{user.name} to My cBas Site ")
  end

  def try_email(user)
    init_var
    @user = user

    mail(:to => user.email, :subject => "send email By rails I try it" ,:cc =>"ong_dkrab@hotmail.com")
  end

  def weekly_mail(email)
    init_var
    mail(:to => email, :subject => "tryIt" , cc:"ong_dkrab@hotmail.com")
  end

  def finished_work(work)
    init_var
    @work = work
    @user = work.user
    mail(:to => work.user.email, :subject => "Your #{work.title} has finished")
  end

  private
    def init_var
      @url = ENV["SERVER_HOST_NAME"]
    end
end