require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test "new user is empty so invalid" do
		user = User.new
		assert !user.valid?	
	end

	test "two user fixtures loaded" do
		num = User.count
		assert_equal num, 2 	
	end
  
	test "a user is named james" do
		user = User.find_by_first_name("James")
		assert_match user.first_name, "James" 	
	end

	test "fixture has name Gaston" do
		assert_match(users(:james).last_name, "Gaston") 
	end
	
  
end
