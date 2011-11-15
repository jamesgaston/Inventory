class Country < ActiveRecord::Base
	has_many :provinces

	scope :ordered, order("name")
end
