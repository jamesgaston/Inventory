module ItemsHelper

  def link_to_next_item(current_item)
    take_next_flag = false

    items = Item.find_my_items(current_user)
    # items = Item.where("user_id == ?", current_user.id).order('Name')
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

    items = Item.find_my_items(current_user)
    #   items = Item.where("user_id == ?", current_user.id).order('Name')
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

  def describe_their_ownership_for(item)
    if item.forsale
      return "is selling a"
    elsif item.wanted
      return "wants to buy a"
    else
      return "owns "
    end
  end

  def describe_my_ownership_for(item)
    if item.forsale
      return "I am selling a"
    elsif item.wanted
      return "I want to buy a"
    else
      return "I own a"
    end
  end

  def describe_my_ownership_brief_for(item)
    if item.forsale
      return "I want to sell"
    elsif item.wanted
      return "I want to buy"
    else
      return "I own"
    end
  end
end
