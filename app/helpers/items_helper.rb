module ItemsHelper
	
def link_to_next_item(current_item)
		take_next_flag = false
		user = current_user 
		items = Item.where("user_id == ?", user.id).order('Name')   	 	
			if (items.nil? == false) && (items.size > 0) 
				for i in items
		   		if take_next_flag == true
						 return link_to " > ", {:controller=>"items", :action=>"show", :id=>i.id }	
					end
					take_next_flag = (i.id == current_item.id) ? true : false 
				end
		end
				# it the last one is current, we fall through here 
		return " " 	
end

def link_to_prev_item(current_item)
		user = current_user 
		items = Item.where("user_id == ?", user.id).order('Name')   	 	
		prev_item = nil 
		if (items.nil? == false) && (items.size > 0) 
				for i in items
					if (i.id == current_item.id)
						 if prev_item == nil
						 	return "  " 	 
						 else 
						 	return link_to " < ", {:controller=>"items", :action=>"show", :id=>prev_item.id  }	
						 end 	
					end
					prev_item = i 	
				end
		end 
		return " " 		
end

end
