class AddDeletedAtToBusinesses < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :deleted_at, :datetime
  end
end
