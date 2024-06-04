class BillsController < ApplicationController
    before_action :require_user
    def show
    end

    def index
    end
    
    def new
        @parkingzone = Parkingzone.find(params[:parkingzone_id])
        @vehicle_number = params[:vehicle_number]
        @duration_in_days = params[:duration_in_days] 
        @duration_in_hours = params[:duration_in_hours]
    end

    def create
        @parkingzone = Parkingzone.find(params[:parkingzone_id])
        @parkingslot = @parkingzone.parkingslots.where(active: true, status: false).order("RANDOM()").limit(1).first
        if @parkingslot == nil
            flash[:alert] = "Booking failed -- There are no free slots available currently"
            redirect_to parkingzones_path
        end

        @vehicle_number = params[:vehicle_number]
        @duration_in_days = params[:duration_in_days].to_i
        @duration_in_hours = params[:duration_in_hours].to_i
        @duration = @duration_in_days * 24 + @duration_in_hours
        @amount = params[:amount]
        @bill = Bill.new(user_id: current_user.id, parkingslot_id: @parkingslot.id, vehicle_number: @vehicle_number, checkin_time: Time.now, duration: @duration, amount: @amount)
        
        if @bill.save
            @parkingslot.status = true
            @parkingslot.save
            @parkingzone.free_slots = @parkingzone.free_slots - 1
            @parkingzone.save 

            generate_qr_code(@bill)

            flash[:notice] = "You have successfully booked a slot"
            redirect_to user_active_path(current_user)
        else
            flash[:alert] = "Booking failed"
            redirect_to parkingzones_path
        end
    end

    def edit
        @bill = Bill.find(params[:id])
        @parkingslot = Parkingslot.find(@bill.parkingslot_id)
        @parkingzone = Parkingzone.find(@parkingslot.parkingzone_id)
    end

    def update
        @bill = Bill.find(params[:id])
        @amount = params[:amount]
        @parkingslot = Parkingslot.find(@bill.parkingslot_id)
        @parkingzone = Parkingzone.find(@parkingslot.parkingzone_id)
        @bill.checkout_time = Time.now
        @parkingslot.status = false
        @parkingzone.free_slots = @parkingzone.free_slots + 1
        @bill.amount=@bill.amount+@amount.to_i
        @bill.save
        @parkingslot.save
        @parkingzone.save
        flash[:notice] = "You can checkout the vehicle #{@bill.vehicle_number} from parking zone #{@parkingzone.name}, parking slot #{@parkingslot.slot_number}"
        redirect_to root_path
    end

    private
    def generate_qr_code(bill)
        qr = RQRCode::QRCode.new("Bill ID: #{bill.id}, Vehicle: #{bill.vehicle_number}, Check-in Time: #{bill.checkin_time}, Duration: #{bill.duration}")
        qr_svg = qr.as_svg(module_size: 4)
        bill.qr_code = qr_svg
        bill.save
    end    
end