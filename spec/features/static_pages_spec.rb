=begin
RSpec.describe "StaticPages", :type => :request do
  describe "GET /static_pages" do
    it "works! (now write some real specs)" do
      get static_pages_index_path
      expect(response.status).to be(200)
    end
  end
end
=end

require 'spec_helper'

describe "Static pages", type: :request do

    subject { page }

    shared_examples_for "all static pages" do
        it { should have_selector('h1', text: heading) }
        it { should have_title(full_title(page_title)) }

        describe "header" do
            it { should have_link "Home" }
            it { should have_link "Help" }
            it { should have_link "sample app" }
        end

        describe "footer" do
            it { should have_link "About" }
            it { should have_link "Contact" }
            it { should have_link "News" }
        end

        describe "when user not signed in" do
            it { should have_link 'Sign in' }
            it { should_not have_link 'Users' }
            it { should_not have_link 'Profile' }
            it { should_not have_link 'Settings' }
            it { should_not have_link 'Sign out' }
        end
        
    end

    describe "Home Page" do
        before { visit root_path }
        let(:heading)    { 'Sample App' }
        let(:page_title) { '' }

        it_should_behave_like "all static pages"
        it { should_not have_title(full_title("Home")) }
        it { should have_link 'Rails Tutorial' }
    end

    describe "Help Page" do
        before { visit help_path }
        let(:heading)    { 'Help' }
        let(:page_title) { 'Help' }

        it_should_behave_like "all static pages"
    end

    describe "About Page" do
        before { visit about_path }
        let(:heading)    { 'About Us' }
        let(:page_title) { 'About Us' }

        it_should_behave_like "all static pages"
    end

    describe "Contact Page" do
        before { visit contact_path }
        let(:heading)    { 'Contact' }
        let(:page_title) { 'Contact' }

        it_should_behave_like "all static pages"
    end

    it "should have the right links on the layout" do
        visit root_path
        click_link "About"
        expect(page).to have_title(full_title('About Us'))
        click_link "Help"
        expect(page).to have_title(full_title('Help'))
        click_link "Contact"
        expect(page).to have_title(full_title('Contact'))
        click_link "Home"
        expect(page).to have_title(full_title(''))
        click_link "Sign up now!"
        expect(page).to have_title(full_title('Sign up'))
        click_link "sample app"
        expect(page).to have_title(full_title(''))
    end
end
