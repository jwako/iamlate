namespace :scheduler do

  def logging_process(task)
    logger = Logger.new("log/#{task}_#{Time.now.strftime('%Y_%m_%d_%H_%M')}.log")
    start_time = Time.now
    logger.info "#{task} at #{start_time}"
    
    yield logger

    end_time = Time.now
    logger.info "successfully done at #{end_time}"
    logger.info "Duration: #{(end_time - start_time).round(1)} sec."
  end

  desc "Notify delay to users"
  task :notify_delay_to_users => :environment do
    logging_process("notify_delay_to_users") do |logger|
      client = Iamlate::API.new
      infos = client.getTrainInfo
      infos.each do |info|
        if info["odpt:trainInformationText"] != AS_PER_USUAL_MESSAGE
          railway = Notification::RAILWAY[Notification::RAILWAY_CODE[info["odpt:railway"]]]
          current = DateTime.iso8601(info["dc:date"]).strftime("%H:%M:%S")
          notifications = Notification.only_active.where(railway: railway).where("start_at <= ? AND end_at >= ?", current, current)
          notifications.each do |n|
            Users::Mailer.notify_delay(n, info["odpt:trainInformationText"]).deliver
            logger.info n.email
          end
        end
      end
    end
  end

end