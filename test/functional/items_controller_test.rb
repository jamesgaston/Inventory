require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
 
test "show index" do
	get :index
	assert_response :success
end


test "show an item" do
	get :show, :id => "2"
	assert_response :success
end


end
