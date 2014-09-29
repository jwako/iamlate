class ApprovesController < ApplicationController

  def index
    token = params[:token] if params[:token]
    if token
      notification = Notification.find_by(token: token)
      notification.update_attributes!(active: true, token: nil) if notification
    end
    return redirect_to root_path, alert: "該当する通知が存在しません。" if token.nil? || notification.nil?
  end
end
