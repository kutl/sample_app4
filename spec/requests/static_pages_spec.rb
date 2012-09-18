require 'spec_helper'

describe "StaticPages" do

  subject {page}
  describe "Home page" do
  	before {visit root_path}

    it { should have_selector('h1', text: 'Sample App') } 	 
  	it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector('title', text: '| Home') }
  end
  describe "Help page" do
    before {visit help_path}
  	it { should have_selector('h1', text: 'Help') }
  	it { should have_selector('title', text: full_title('Help')) }
  end
  describe "About page" do
    before {visit about_path}
  	it { should have_selector('h1', text: 'About Us') }
  	it { should have_selector('title', text: full_title('About Us')) }
  end
  describe "Contacts page" do
    before {visit contacts_path}
  	it { should have_selector('h1', text: 'Contacts') }
  	it { should have_selector('title', text: full_title('Contacts')) }
  end
  it "should have the right links on the layout" do
    visit root_path
    click_link "Sign in"
    page.should have_selector( 'title', text: full_title('Sign in'))
    click_link "About"
    page.should have_selector( 'title', text: full_title('About Us'))
    click_link "Help"
    page.should have_selector( 'title', text: full_title('Help'))
    click_link "Contacts"
    page.should have_selector( 'title', text: full_title('Contacts'))
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector( 'title', text: full_title('Sign up'))


  end
end
