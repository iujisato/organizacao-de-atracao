class AddUserIdToAttraction < ActiveRecord::Migration
  def change
    add_column :attractions, :user_id, :reference
  end
end
