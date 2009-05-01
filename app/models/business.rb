class Business < ActiveRecord::Base
  attr_accessor :current_lat, :current_lng
  
  acts_as_mappable
  before_validation :geocode_address

  private
  def geocode_address
    if (self.geolocalized_address != self.address)
      if (self.current_lat == self.lat && self.current_lng == self.lng)
        geo=Geokit::Geocoders::MultiGeocoder.geocode(address)
        errors.add(:address, "Could not Geocode address") if !geo.success
        self.lat, self.lng, self.geolocalized_address = geo.lat, geo.lng, self.address if geo.success
      else
        self.geolocalized_address = self.address
      end
    end
  end
end
