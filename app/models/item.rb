class Item < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	belongs_to :ownership
	
	delegate  :email, :to => :user 
	validates :name, :presence => true
  	validates :category_id, :presence => true
	validates :ownership_id, :presence => true
	validates :number, :presence => true, 
				numericality: {greater_than_or_equal_to: 1}

end
