class AchievementMailer < ApplicationMailer
  def complete
    @user = User.find(params[:user_id])
    @activity = Activity.find(params[:activity_id])
    @subject = "Congratulations on completing an activity"

    mail(to: @user, subject: @subject)
  end

  def completed_course
    @user = User.find(params[:user_id])
    @subject = "Take the next step on your subject knowledge certificate"

    mail(to: @user, subject: @subject)
  end
end
