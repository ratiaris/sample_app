require 'spec_helper'

describe "Microposts Pages", :type => :request do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { valid_signin user }

	describe "in the home page" do

		describe "posting a micropost" do
			before { visit root_path }

			describe "with invalid information" do 

				it "should not create a micropost" do
					expect { click_button "Post"}.not_to change(Micropost, :count)
				end

				describe "should display an error message" do
					before { click_button "Post" }
					it { should have_error_message } 
				end
			end

			describe "with ivalid information" do 
				before { fill_in 'micropost_content', with: "Lorem ipsum"}

				it "should create a micropost" do
					expect { click_button "Post"}.to change(Micropost, :count).by 1
				end
			end
		end

		describe "clicking on a delete link" do
			before { FactoryGirl.create(:micropost, user: user) }

			describe "belonging to the user" do 
				before { visit root_path }

				it "should delete a micropost" do
					expect { click_link "delete" }.to change(Micropost, :count).by -1
				end
			end
		end

	    describe "with an empty feed" do
	        before do
	            visit root_path
	        end

	        it { should have_content "No micropost" }
	        it { should_not have_selector("ol") }
	    end

	    describe "with 1 item feed" do
	        let(:content) { "Lorem ipsum" }

	        before do
	            FactoryGirl.create(:micropost, user: user, content: content)
	            visit root_path
	        end

	        it { should have_content "1 micropost" }
	        it "should render 1 micropost" do
	            user.feed.each do | item |
	                expect(page).to have_selector("li##{item.id}", text: item.content)
	            end
	        end
	    end

	    describe "with 3 items feed" do
	        before do
	            FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
	            FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
	            FactoryGirl.create(:micropost, user: user, content: "Blah blah blah")
	            visit root_path
	        end

	        it { should have_content "3 microposts" }
	        it "should render each micropost" do
	            user.feed.each do | item |
	                expect(page).to have_selector("li##{item.id}", text: item.content)
	            end
	        end
	    end

		describe "with a paginated feed" do
			before do
				31.times do | n |
					FactoryGirl.create(:micropost, user: user,
						content: "Lorem ipsum dolor sit amet #{n}")
				end
				visit root_path
			end
			after { Micropost.delete_all }

			it { should have_selector "div.pagination" }

			it "should list each micropost" do
				Micropost.paginate(page: 1).each do | item |
					expect(page).to have_selector("li##{item.id}", text: item.content)
				end
			end
		end    
	end

	describe "in the profile page" do

		describe "of another user" do
			let(:wrong_user) { FactoryGirl.create(:user) }
			let(:content) {  "Lorem ipsum dolor sit amet" }

			before do
				FactoryGirl.create(:micropost, user: wrong_user, content: content )
				visit user_path(wrong_user)
			end

			it { should have_title(full_title wrong_user.name)}
	        it { should have_content "Microposts (1)" }
	        it { should have_selector("li", text: content ) }
			it { should_not have_link "delete" }
		end

		describe "clicking on a delete link" do
			before do
				FactoryGirl.create(:micropost, user: user)
				visit user_path(user)
			end

			it "should delete a micropost" do
				expect { click_link "delete" }.to change(Micropost, :count).by -1
			end
		end

		describe "with paginated microposts" do
			before do
				31.times do | n |
					FactoryGirl.create(:micropost, user: user,
						content: "Lorem ipsum dolor sit amet #{n}")
				end
				visit user_path(user)
			end
			after { Micropost.delete_all }

			it { should have_selector "div.pagination" }

			it "should list each micropost" do
				Micropost.paginate(page: 1).each do | item |
					expect(page).to have_selector("li", text: item.content)
				end
			end
		end    
	end
end
