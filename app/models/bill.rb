class Bill < ApplicationRecord
    serialize :qr_code, JSON
    belongs_to :user
    belongs_to :parkingslot
end