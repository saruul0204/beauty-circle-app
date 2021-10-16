class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :country
      t.string :city
      t.string :open_hour
      t.string :close_hour
      t.string :phone_number
      t.string :email
      t.string :facebook_url
      t.string :instagram_url

      t.timestamps
    end
  end
end
