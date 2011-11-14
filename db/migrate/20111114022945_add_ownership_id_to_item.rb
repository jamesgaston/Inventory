class AddOwnershipIdToItem < ActiveRecord::Migration
  def change
     add_column :items, :ownership_id, :integer
     remove_column :items, :status_id 
  end
end
