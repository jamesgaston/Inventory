module UsersHelper

def num_items(user_id)
		items = Item.find_all_by_user_id(user_id) 
		return items.size 
end

def first_name(user_id)
	if User.find_by_id(user_id).first_name.blank? 
		return "Anonymous"
	else
		return User.find_by_id(user_id).first_name
	end
end

def city(user_id)
	if User.find_by_id(user_id).city.blank? 
		return ""
	else
		return User.find_by_id(user_id).city
	end
end

def province(user_id)
	if User.find_by_id(user_id).province.blank? 
		return ""
	else
		return User.find_by_id(user_id).province.name
	end
end

def province_abbr(user_id)
	if User.find_by_id(user_id).province.blank? 
		return ""
	else
		return User.find_by_id(user_id).province.abbreviation
	end
end


end
