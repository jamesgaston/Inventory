module SessionsHelper


# method: sign_in(user)
# 
# place a remember_token as a cookie on the user's browser and then use the token
# to find the user record in the database as the user moves between pages
def sign_in(user)

		# permanent means the expiration date is 20 year from now
		# signed makes the cookie secure, user id isn't exposed
	cookies.permanent.signed[:remember_token] = [user.id, user.salt]
	
		# create instance variable current_user, 
		# which is accessible in controllers and views
	self.current_user = user
end


# method  current_user=(user)
# 	
# set an instance variable to store the current user 
# called by sign_in()
# defines a setter on the current_user instance 
def current_user=(user)
	@current_user = user 
end

# method  current_user
#
# sets the instance variable to the remember_token only if the variable is undefined 
def current_user
	@current_user ||= user_from_remember_token
end


# method signed_in
#
# a user is signed in if current_user is not nil 
def signed_in?
	!current_user.nil? 
end

# method sign_out
# 
# delete the remember token and set current user to nil 
def sign_out
	cookies.delete(:remember_token)
	self.current_user = nil
end

def signed_in_as_admin
	if !current_user.nil? 
		return User.find(current_user).isadmin
	else
		return false	
	end
end
	


private

# method  user_from_remember_token
# 
# the asterisk operator allows us to use a two-element array as an argument
# to a method expecting two variables 
def user_from_remember_token
	User.authenticate_with_salt(*remember_token)
end


# method remember_token 
#
def remember_token

		# cookies.signed returns an array of two elements, user id and salt
		# but it is considered better to pass separate arguments to methods 
		# rather than arrays of arguments
		# returns an array of nil, nil if cookies.signed is nil
		
	cookies.signed[:remember_token] || [nil,nil]
end


end
