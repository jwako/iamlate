class HomeController < ApplicationController
  before_filter :authenticate_user!

  def show
    @notifications = current_user.notifications
    @notification = current_user.notifications.new
  end

  def create
     @notification = current_user.notifications.new notifaction_params
    if @notification.save
      redirect_to :home, notice: "正しく登録されました。"
    else
      render :show
    end
  end

  private

  def setup_notification
    @notification = current_user.notifications.new notifaction_params
  end

  def notifaction_params
    params.require(:notification).permit(:email, :railway, :start_at, :end_at)
  end

end
