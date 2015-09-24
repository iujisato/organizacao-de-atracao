class RemoveDateFromAttractions < ActiveRecord::Migration
  def change
    remove_column :attractions, :date, :date
  end
end
