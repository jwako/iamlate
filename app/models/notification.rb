class Notification < ActiveRecord::Base
  belongs_to :user

  RAILWAY = { "丸ノ内線" => 100, 
    "日比谷線" => 200, 
    "東西線" => 300, 
    "千代田線" => 400, 
    "有楽町線" => 500, 
    "半蔵門線" => 500, 
    "南北線" => 700, 
    "副都心線" => 800
  }

  before_create :setup_token
  after_create :notify_user

  private

  def setup_token
    # TODO set token
    self.token = "HOGEHOGE"
  end

  def notify_user
    # TODO send email to the user
  end

end
