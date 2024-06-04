class User < ApplicationRecord 
    has_one_attached :avatar
    has_many :bills
    has_many :parkingslots, through: :bills
    validates :username, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 105}, format: {with: VALID_EMAIL_REGEX}
    has_secure_password

    validates :DOB, presence: true
    validate :DOB_should_be_at_least_18

    private
    def DOB_should_be_at_least_18
      if self.DOB.present? && self.DOB > 18.years.ago.to_date
        errors.add(:DOB, "You must be at least 18 years old")
      end
    end
end 