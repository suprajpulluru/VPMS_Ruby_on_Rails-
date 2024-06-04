class Parkingslot < ApplicationRecord
    belongs_to :parkingzone
    has_many :bills
    has_many :users, through: :bills
end