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
        if info["odpt:trainInformationText"] != "現在、平常どおり運転しています"
          railway = Notification::RAILWAY[Notification::RAILWAY_CODE[info["odpt:railway"]]]
          notifications = Notification.only_active.where(railway: railway)
          notifications.each do |notification|
            # TODO send email
            logger.info notification.email
          end
        end
      end
    end
  end

end