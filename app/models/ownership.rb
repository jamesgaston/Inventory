class Ownership < ActiveRecord::Base
	has_many :items
	scope :ordered, order("name")
	validates :name, :presence => true,
				 :uniqueness => { :case_sensitive => false}	
end
