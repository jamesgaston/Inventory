module ItemsHelper

def next_item(item_id)
   user = current_user  
   items = Item.where("user_id = ?", user.id).order('Name')   	
	item_ids = Array.new
	c = 0
	current = 0
	for i in items
		 item_ids[c] = i.id
		 if i.id == item_id
		 	current = c
		 end   
		 c = c + 1
	end 
	if current < (items.size - 1)
		return item_ids[current + 1]
	else
		return item_id
	end
		  
end


def prev_item(item_id)
   user = current_user  
   items = Item.where("user_id = ?", user.id).order('Name')   	
	item_ids = Array.new
	c = 0
	current = 0
	for i in items
		 item_ids[c] = i.id
		 if i.id == item_id
		 	current = c
		 end   
		 c = c + 1
	end 
	if current > 0
		return item_ids[current - 1]
#		return link_to "<", {:controller=>"items", :action=>"show", :id=> prev_item(@item.id) } 

	else
		return item_id
	end
		  
end




def find_sameitem_messages(item_id, recipient_id)
  
  if item_id
		@sameitem_messages = Message.where("item_id == ? AND ((sender_id == ? AND recipient_id == ?) OR (recipient_id == ? AND sender_id == ?))",
		  item_id, recipient_id, @current_user.id, recipient_id, @current_user.id ).order(:created_at) 
		if @sameitem_messages && (@sameitem_messages.size > 0) 
			return @sameitem_messages.size.to_s
		end 
	end
	return ""
end

def item_name(item_id)
   if item_id
		return Item.find_by_id(item_id).name
	else
		return "item unknown"
	end
end


def item_ownership(item_id)
   if item_id
		 o_id = Item.find_by_id(item_id).ownership_id
		 return Ownership.find_by_id(o_id).name 
	else
		return "unknown"
	end
end

def find_samename_items(item)
	ownership = Ownership.find_by_id(item.ownership_id)
   @samename_items_title = ""	
	@samename_items_count = 0

	case ownership.id 
	when 1  # currently own 
		@samename_items = nil 
		@samename_items_title = ""

	when 2, 6  #want to buy(2) or get for free (6)   
			# want to search ownership categories 
		@samename_items = Item.where('ownership_id == 3 AND name == ?', item.name)
		if @samename_items.size > 0
			  @samename_items_count = @samename_items.size
		end
		@samename_items_title = (item.name + " for Sale")

	else # must want to sell(3) or give away(4) or sell or trade (5)  
		@samename_items = Item.where('ownership_id == 2 AND name == ?', item.name)  
		if @samename_items.size > 0
			  @samename_items_count = @samename_items.size
		end

		@samename_items_title = ("Wants " + item.name)
	end    
	
end




def get_ownership(item)
	if item.ownership_id
	 	return Ownership.find_by_id(item.ownership_id).name.downcase 
	else
		return nil
	end
end 

def get_category(item)
	if item.category_id 
	 	return Category.find_by_id(item.category_id).name 
	else
		return nil
	end
end 

def which_is_for_sale( item_one, item_two )
	item1 = Item.find(item_one)
	item2 = Item.find(item_two)
	if( item1.ownership_id == 3 ) # want to sell 
		return item_one
	else
		return item_two 
	end
end 

end
