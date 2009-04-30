class AddGeolocalizedSupportToBusinesses < ActiveRecord::Migration
  def self.up
    add_column :businesses, :lat, :float
    add_column :businesses, :lng, :float
    add_column :businesses, :geolocalized_address, :string
  end

  def self.down
    remove_column :businesses, :geolocalized_address
    remove_column :businesses, :lng
    remove_column :businesses, :lat
  end
end
