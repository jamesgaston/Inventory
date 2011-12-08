class AddItemIdSellerToMessage < ActiveRecord::Migration
  def up
		add_column :messages, :seller_item_id, :integer
		add_column :messages, :buyer_item_id, :integer
		add_column :messages, :sender_user_id, :integer
  end
  
def down
		remove_column :messages, :seller_item_id
		remove_column :messages, :buyer_item_id
		remove_column :messages, :sender_user_id
end 	

end
