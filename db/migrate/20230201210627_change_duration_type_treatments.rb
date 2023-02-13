class ChangeDurationTypeTreatments < ActiveRecord::Migration[6.1]
  def change
    change_column :treatments, :duration, :integer, using: 'duration::integer', default: 60
  end
end
