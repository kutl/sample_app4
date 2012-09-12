require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    it {should have_selector('h1', text: 'Sign up')}
    it {should have_selector('title', text: full_title('Sign up'))}
  end

  describe "profile page" do
  	let(:user2) { FactoryGirl.create(:user)}

    before { visit user_path( user2 ) }
    it {should have_selector('h1', text: user2.name)}
    it {should have_selector('title', text: user2.name ) }
  end

   describe "signup" do
     before {visit signup_path}

     let(:submit) { "Create my account" }

     describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
          
        end

        describe "after submission" do
          before {click_button submit}
          it { should have_selector('title', text: "Sign up")}
          it { should have_content('error')}
          it { should_not have_content('Password digest')}
        end
     end

     describe "with valid information" do
      before do
        fill_in "Name",         with: "Example user"
        fill_in "Email",        with: "example@example.com"
        fill_in "Password",     with: "qwerty1234"
        fill_in "Confirmation", with: "qwerty1234"
      end
      it "should create a user" do
        
        expect { click_button submit }.to change(User, :count).by(1)

      end 

      describe "after saving a user" do
        before {click_button submit}
        let(:user)  { User.find_by_email( "example@example.com")}
        it { should have_selector('title', text: user.name)}
        it { should have_selector('div.alert.alert-success', text: 'Welcome')}

      end   
     end 

   end

end
