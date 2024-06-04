class ParkingslotsController < ApplicationController
    before_action :require_user, only: [:index, :edit, :create]
    before_action :require_same_user, only: [:show, :destroy]
    def show
        @parkingslot = Parkingslot.find(params[:id]) 
    end

    def create
        @parkingzone = Parkingzone.find(params[:parkingzone_id])
        @parkingslot = Parkingslot.new(parkingzone_id: @parkingzone.id, slot_number: @parkingzone.total_slots+1, status: false, active: true)
    
        if @parkingslot.save
            @parkingzone.total_slots+=1
            @parkingzone.free_slots+=1
            @parkingzone.save
            flash[:notice] = "Successfully added a new parking slot"
            redirect_to parkingzone_path(@parkingzone)
        else
            flash[:alert] = "Parking slot addition is unsuccessful"
            redirect_to parkingzone_path(@parkingzone)
        end
    end

    def edit
        @parkingslot = Parkingslot.find(params[:id])
        @parkingzone = Parkingzone.find(@parkingslot.parkingzone_id)
    end

    def update
    end

    def destroy
        @parkingslot = Parkingslot.find(params[:id]) 
        @parkingzone = Parkingzone.find(@parkingslot.parkingzone_id)
        if @parkingslot.active 
            if @parkingslot.status == false
                @parkingslot.update(active: false)
                flash[:notice] = "Parking slot blocked successfully"
                redirect_to parkingzone_path(@parkingzone)
            else
                flash[:alert]="You cannot block the slot, since it is filled"
                redirect_to parkingzone_path(@parkingzone)
            end
        else
            @parkingslot.update(active: true)
            redirect_to parkingzone_path(@parkingzone)
        end
    end

    private
    def require_same_user
        @parkingslot = Parkingslot.find(params[:id]) 
        @parkingzone = Parkingzone.find(@parkingslot.parkingzone_id) 
        if !logged_in? || current_user.id != @parkingzone.incharge_user_id   
            flash[:alert] = "You are not allowed to do this action"
            redirect_to root_path
        end
    end
end