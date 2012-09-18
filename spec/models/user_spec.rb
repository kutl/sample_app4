require 'spec_helper'

describe User do
  before do  @user = User.new(name: "Example User", email: "user@example.com",
    password: "foobar", password_confirmation: "foobar") 

  end
  subject {@user}
  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:remember_token)}
  it {should respond_to(:authenticate)}

  it {should be_valid }

  describe "when name is not present" do
    before { @user.name = " "}
    it { should_not be_valid }
  end

  describe "when email is not presented" do
  	before { @user.email = " "}
  	it { should_not be_valid }
  end	

  describe "when name is too long" do
  	before { @user.name = "a" *51}
    it { should_not be_valid }
  end

  describe "email format is invalid" do
    it "should be invalid" do
     addresses = %w[sr@foo,com u_ee_ee.com us@dff. foo@bar_baz.ru foo@bar+baz.com]
     addresses.each do |invalid_address|
      @user.email = invalid_address
      @user.should_not be_valid
     end
    end
  end

  describe "when email is valid" do
    it "should be valid" do
      addresses = %w[ku@ff.tl asss.ass.ass@rr.ru _uu@uu.ru A_djd@dd.uss.uss.uss.us
       a+B@ddss.es ]
       addresses.each do |valid_address|
         @user.email = valid_address
         @user.should be_valid
       end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_sam_email = @user.dup
      user_with_sam_email.email = @user.email.upcase
      user_with_sam_email.save
    end
    it {should_not be_valid}

  end

  describe "when password is not present" do
    before {@user.password = @user.password_confirmation = " " }
    it {should_not be_valid}

  end
  describe "when password does not match password confirmation" do
    before do 
      @user.password = "foofoofoo"
      @user.password_confirmation = "barbarbar" 
    end
    it {should_not be_valid}

  end
  describe "when password is nil" do
    before do 
      @user.password = nil
      
    end
    it {should_not be_valid}

  end
  
  describe "when password is too short" do
    before do 
      
      @user.password = @user.password_confirmation = "a"*5
    end
    it {should_not be_valid}

  end

  describe "return value of authentication method" do
    before { @user.save}
    let(:found_user) { User.find_by_email@user.email}
    
    describe "with valid password" do
        it { should == found_user.authenticate(@user.password)}
    end
    describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid")}
        it { should_not == user_for_invalid_password }
        specify { user_for_invalid_password.should be_false}
    end
  end

  describe "remember_token" do
    before {@user.save}
    its(:remember_token) {should_not be_blank}
  end
  
end
