class Notification < ActiveRecord::Base
  belongs_to :user
  has_many :histories, class_name: "NotificationHistory", foreign_key: "notification_id", dependent: :destroy
  # has_many :notification_histories

  RAILWAY = { "丸ノ内線" => 100, 
    "日比谷線" => 200, 
    "東西線" => 300, 
    "千代田線" => 400, 
    "有楽町線" => 500, 
    "半蔵門線" => 500, 
    "南北線" => 700, 
    "副都心線" => 800
  }

  RAILWAY_CODE = {
    "odpt.Railway:TokyoMetro.Marunouchi" => "丸ノ内線",
    "odpt.Railway:TokyoMetro.Hibiya" => "日比谷線",
    "odpt.Railway:TokyoMetro.Tozai" => "東西線",
    "odpt.Railway:TokyoMetro.Chiyoda" => "千代田線",
    "odpt.Railway:TokyoMetro.Yurakucho" => "有楽町線",
    "odpt.Railway:TokyoMetro.Hanzomon" => "半蔵門線",
    "odpt.Railway:TokyoMetro.Namboku" => "南北線",
    "odpt.Railway:TokyoMetro.Fukutoshin" => "副都心線"
  }

  scope :only_active, -> { where(active: true) }

  validates :email, :railway, :start_at, :end_at, presence: true

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
