class AddHourToAttractions < ActiveRecord::Migration
  def change
    add_column :attractions, :hour, :time
  end
end
