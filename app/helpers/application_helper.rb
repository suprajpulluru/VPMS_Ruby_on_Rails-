module ApplicationHelper
    def gravatar_for (user,options = {size: 80})
        email_address = user.email.downcase 
        hash = Digest::SHA256.hexdigest(email_address)
        size = options[:size]
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
    end

    def calculate_amount_in_rupees(duration_in_days,duration_in_hours,parkingzone_id)
        @parkingzone = Parkingzone.find(parkingzone_id)
        duration_in_days = duration_in_days.to_i
        duration_in_hours = duration_in_hours.to_i
        return duration_in_hours*@parkingzone.fare1 + duration_in_days*@parkingzone.fare2 
    end
end