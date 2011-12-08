class Message < ActiveRecord::Base
belongs_to :user
belongs_to :item
validates :buyer_item_id, :presence => true
validates :buyer_user_id, :presence => true
validates :seller_item_id, :presence => true
validates :seller_user_id, :presence => true
validates :sender_user_id, :presence => true
validates :message_text, :presence => true


def self.new_message(my_item, other_item)
	if my_item.forsale 
		return Message.new( :seller_item_id => my_item.id,
								:seller_user_id => my_item.user_id, 
								:buyer_item_id => other_item.id, 
								:buyer_user_id => other_item.user_id, 
								:sender_user_id => my_item.user_id) 
			 
	elsif my_item.wanted
		return Message.new(  :buyer_item_id => my_item.id,
									:buyer_user_id => my_item.user_id,
									:seller_item_id => other_item.id, 
									:seller_user_id => other_item.user_id, 
									:sender_user_id => my_item.user_id ) 
	else
		return nil 
	end
end


def self.find_all_for_item(item)
	 return Message.where('seller_item_id  == ? OR buyer_item_id  == ?', item.id, item.id ) 
end

			# it is my message, but which item is mine, the buyer_item or seller_item? 
def my_item
		return self.sender_user_id == self.seller_user_id ? self.seller_item_id : self.buyer_item_id
end 
	
 
end
