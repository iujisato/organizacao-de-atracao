class AddDateToAttractions < ActiveRecord::Migration
  def change
    add_column :attractions, :date, :date
  end
end
