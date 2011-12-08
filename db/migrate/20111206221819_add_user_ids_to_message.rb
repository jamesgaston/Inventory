class AddUserIdsToMessage < ActiveRecord::Migration
	def up
		add_column :messages, :seller_user_id, :integer
		add_column :messages, :buyer_user_id, :integer
	end
  
	def down
		remove_column :messages, :seller_user_id
		remove_column :messages, :buyer_user_id
	end 	

end
