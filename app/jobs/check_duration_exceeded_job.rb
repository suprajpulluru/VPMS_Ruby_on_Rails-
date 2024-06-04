class CheckDurationExceededJob < ApplicationJob
    queue_as :default

    def perform 
        Bill.where(checkout_time: nil).each do |bill|
            if bill.checkin_time + bill.duration.hours <= Time.now.utc()  && Time.now.utc() <= bill.checkin_time + bill.duration.hours + 1.minute
                DurationExceededNotificationMailer.notify(bill).deliver_now
            end              
        end
    end
end