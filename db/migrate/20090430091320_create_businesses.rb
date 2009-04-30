class CreateBusinesses < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :businesses
  end
end
