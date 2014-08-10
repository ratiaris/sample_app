require 'rails_helper'

describe "User pages" do

    subject { page }

    describe "Signup Page" do
        before { visit signup_path }

        it { should have_content('Sign up') }

        it { should have_title(full_title('Sign up')) }
    end
end
