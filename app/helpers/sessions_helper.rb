module SessionsHelper

	
	def log_in(user)   # Logs in the given user.
		session[:user_id] = user.id
	end

	def remember(user)   # Remembers a user in a persistent session.
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	def current_user           # Returns the current logged-in user (if any).
		if (user_id = session[:user_id])
    		@current_user ||= User.find_by(id: user_id)
    	elsif (user_id = cookies.signed[:user_id])
      		user = User.find_by(id: user_id)
      		if user && user.authenticated?(cookies[:remember_token])
        	log_in user
        	@current_user = user
    		end
   		end
	end
# Returns true if the user is logged in, false otherwise.
	def logged_in?  	
    	!current_user.nil?
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def log_out              # Logs out the current user.
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end
end
