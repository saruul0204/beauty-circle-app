class AddCityToBusinesses < ActiveRecord::Migration[6.1]
  def change
    add_reference :businesses, :city, foreign_key: true
  end
end
