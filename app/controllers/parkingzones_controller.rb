class ParkingzonesController < ApplicationController
    before_action :require_user, only:[:index, :edit]
    before_action :require_same_user, only: [:show]
    def index
        current_user_parkingzones = Parkingzone.where(incharge_user_id: current_user.id)
        other_parkingzones = Parkingzone.where.not(incharge_user_id: current_user.id)
        @parkingzones = current_user_parkingzones + other_parkingzones
    end

    def show
        @parkingzone = Parkingzone.find(params[:id])
        @parkingslots = Parkingslot.where(parkingzone_id: @parkingzone.id)
    end

    def edit
        @parkingzone = Parkingzone.find(params[:id]) 
    end

    def update
    end

    def destroy
    end

    private
    def parkingzone_params
      params.require(:parkingzone).permit(:name, :latitude, :longitude, :total_slots, :free_slots, :fare1, :fare2, :fare3)
    end

    def require_same_user
        @parkingzone = Parkingzone.find(params[:id])
        if !logged_in? || current_user.id != @parkingzone.incharge_user_id
            flash[:alert]="You are not allowed to do this action"
            redirect_to root_path
        end
    end
    

end