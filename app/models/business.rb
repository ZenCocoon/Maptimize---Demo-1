class Business < ActiveRecord::Base
  acts_as_mappable
  before_validation :geocode_address

  private
  def geocode_address
    return if self.address.nil? || (self.geolocalized_address == self.address && !self.lat.nil? && !self.lng.nil?)
    geo=Geokit::Geocoders::MultiGeocoder.geocode(address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng, self.geolocalized_address = geo.lat, geo.lng, self.address if geo.success
  end
end
