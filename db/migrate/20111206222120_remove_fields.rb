class RemoveFields < ActiveRecord::Migration
  def up
  	remove_column :messages, :sender_id
  	remove_column :messages, :recipient_id
  	remove_column :messages, :hide
  	remove_column :messages, :show_email
  	remove_column :messages, :item_id
  	
  end

  def down
  	add_column :messages, :sender_id, :integer
  	add_column :messages, :recipient_id, :integer 
  	add_column :messages, :hide, :boolean
  	add_column :messages, :show_email, :boolean
  	add_column :messages, :item_id, :integer
  end
end
