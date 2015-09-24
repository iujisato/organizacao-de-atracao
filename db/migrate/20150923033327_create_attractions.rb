class CreateAttractions < ActiveRecord::Migration
  def change
    create_table :attractions do |t|
      t.string :name
      t.string :media
      t.date :date
      t.time :hour

      t.timestamps null: false
    end
  end
end
