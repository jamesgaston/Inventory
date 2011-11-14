class Ownership < ActiveRecord::Base
has_many :items

scope :ordered, order("name")

end
