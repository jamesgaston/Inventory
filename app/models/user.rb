require 'digest'
class User < ActiveRecord::Base

		# create a virtual password attribute 
	attr_accessor :password
   attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :country_id, :city, :province_id, :postal_code, :phone, :admin 
  	 
   		# delete the user's items when the user is deleted 
	has_many :items, :dependent => :destroy  
	belongs_to :province

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :email, :presence => true,
					:format => {:with => email_regex },
					:uniqueness => { :case_sensitive => false}

	validates :password, :presence => true,
						:confirmation => true,
						:length => { :within => 6..40 }


	before_save :encrypt_password
	before_update :encrypt_password
	
		# return true if the user's password matches the submitted password
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end	
		
	
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
	def isadmin
		return self.admin == true ? true : false;
	end 
	
	# method authenticate_with_salt()
	#
	# find the user by id
	# verify salt stored in cookie is correct for that user 
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end

		# need an public  way to refer to this user
	def public_name
 		if self.first_name.nil? || self.first_name.blank?
 			return "Someone"
 		else
 			return self.first_name
 		end   
 	end 		
		


		
	private
	
	def encrypt_password
		self.salt = make_salt if new_record?
		self.encrypted_password = encrypt(password)
	end
	
	def encrypt(string)
		secure_hash ("#{salt}--#{string}")
				# string # temporary implementation 
	end
	
	def make_salt
		secure_hash("#{Time.now.utc}--#{password}")
	end
	
	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end
 
 
end
