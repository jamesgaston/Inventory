class Item < ActiveRecord::Base
	OWNER=1       # values fixed      
	FORSALE=3     # for now   
	WANTED=2
	
	belongs_to :user
	belongs_to :category
	belongs_to :ownership
	has_many   :messages, :dependent => :destroy  
	
	delegate  :email, :to => :user 
	delegate  :first_name, :to => :user 
	delegate  :last_name, :to => :user
	delegate  :city, :to => :user
	delegate  :public_name, :to => :user 
	
	 
	validates :name, :presence => true
  	validates :category_id, :presence => true
	validates :ownership_id, :presence => true
	validates :number, :presence => true, 
 				  numericality: {greater_than_or_equal_to: 1}

		
	def self.find_my_items(user)
		return Item.where("user_id == ?", user.id).order('Name')
	end
	
	
	
	def find_items_like_mine
		if self.forsale
			return Item.where('ownership_id == 2 AND lower(name) == ?', self.name.downcase)  
		elsif self.wanted   
			return Item.where('ownership_id == 3 AND lower(name) == ?', self.name.downcase)
	   else    
	  		return nil 	 
	   end    
	end
	
	def find_messages_in_thread(other_item)
		if self.forsale
			return Message.where('seller_item_id  == ? AND buyer_item_id  == ?', self.id, other_item.id)  
		elsif self.wanted   
			return Message.where('buyer_item_id  == ? AND seller_item_id  == ?', self.id, other_item.id)  
      else    
	  		return nil 	
	   end    
	end

	def find_all_messages
		if self.forsale
			return Message.where('seller_item_id  == ?', self.id)  
		elsif self.wanted   
			return Message.where('buyer_item_id  == ?', self.id)  
      else    
	  		return nil 	
	   end    
	end



	def forsale
		 return self.ownership_id == FORSALE 	
	end

	def wanted
		 return self.ownership_id == WANTED  	
	end

	def describe_their_ownership
		if self.forsale
			return "is selling a"   
		elsif self.wanted   
			return "wants to buy a"  
      else    
	  		return "owns " 
	   end    
	end 

	def describe_my_ownership
		if self.forsale
			return "I am selling a"   
		elsif self.wanted   
			return "I want to buy a"  
      else    
	  		return "I own a" 
	   end    
	end 

	def describe_my_ownership_brief
		if self.forsale
			return "I want to sell"   
		elsif self.wanted   
			return "I want to buy"  
      else    
	  		return "I own" 
	   end    
	end 



	
end
