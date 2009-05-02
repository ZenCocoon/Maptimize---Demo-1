class AddGeolocalizedSupportToBusinesses < ActiveRecord::Migration
  def self.up
    change_table(:businesses) do |t|
       t.float :lat, :lng
       t.string :geolocalized_address
     end
  end

  def self.down
    change_table(:businesses) do |t|
       t.remove :lat, :lng, :geolocalized_address
     end
  end
end
