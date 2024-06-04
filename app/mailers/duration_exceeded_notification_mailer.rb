class DurationExceededNotificationMailer < ApplicationMailer
    def notify(bill)
        @bill = bill
        @user = User.find(@bill.user_id)
        @parkingslot = Parkingslot.find(@bill.parkingslot_id)
        @parkingzone = Parkingzone.find(@parkingslot.parkingzone_id)
        mail(to: @user.email, subject: "Parking slot duration exceeded")
    end
end