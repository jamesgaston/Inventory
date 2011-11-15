class Province < ActiveRecord::Base
	belongs_to :country
	has_many :users
	
	scope :ordered, order("country_id").order("name")	
end
