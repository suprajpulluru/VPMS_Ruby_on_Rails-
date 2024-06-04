class PagesController < ApplicationController
    def home
        @parkingzones = Parkingzone.paginate(page: params[:page], per_page: 5) 
        # @parkingzones = Parkingzone.all
    end
end