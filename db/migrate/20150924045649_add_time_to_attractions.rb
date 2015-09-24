class AddTimeToAttractions < ActiveRecord::Migration
  def change
    add_column :attractions, :time, :datetime
  end
end
