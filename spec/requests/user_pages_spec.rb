require 'spec_helper'

describe "User Pages" do
	subject {page}

	describe "Signup Page" do
	
		before {visit signup_path}
	
		it { should have_content ('Sign Up') } 

		it { should have_title (full_title('Sign Up')) }
	end

	describe "Profile Page" do

		let(:user) { FactoryGirl.create(:user)  }
		before {visit user_path(user)}
	
		it { should have_content (user.name) } 
		it { should have_title (full_title(user.name)) }
	end
end
