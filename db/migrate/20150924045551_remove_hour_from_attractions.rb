class RemoveHourFromAttractions < ActiveRecord::Migration
  def change
    remove_column :attractions, :hour, :time
  end
end
