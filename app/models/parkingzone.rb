class Parkingzone < ApplicationRecord 
    validates :latitude, uniqueness: { scope: :longitude, message: "Coordinates combination already exists" }
    has_many :parkingslots, dependent: :destroy
end