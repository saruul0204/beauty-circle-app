class RemoveCityFromBusinesses < ActiveRecord::Migration[6.1]
  def change
    remove_column :businesses, :city, :string
  end
end
