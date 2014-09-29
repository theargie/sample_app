class User < ActiveRecord::Base

	attr_accessor :remember_token

	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 } 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.digest(string)     # Returns the hash digest of the given string.
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  	  BCrypt::Engine.cost
   		BCrypt::Password.create(string, cost: cost)
  	end
	
	 								
  	def User.new_token                # Returns a random token.
   		 SecureRandom.urlsafe_base64
  	end

  	def remember    # Remembers a user in the database for use in persistent sessions.
  		self.remember_token = User.new_token 
  		update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	def authenticated?(remember_token)  # Returns true if the given token matches the digest.
  		BCrypt::Password.new(remember_digest).is_password?(remember_token)
  	end

	def forget           # Forgets a user.
    	update_attribute(:remember_digest, nil)
	end
end
