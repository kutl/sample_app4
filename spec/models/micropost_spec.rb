require 'spec_helper'

describe Micropost do
	let(:user) { FactoryGirl.create(:user) }
  before do
    @micropost = Micropost.new(content: "Lorem ipsum")
    @micropost.user_id = user.id
  end

  subject { @micropost }
  it {should respond_to(:content)}
  it {should respond_to(:user_id)}

  it {should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do

        Micropost.new(user_id: "1")

      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
      
    end
    
  end

  describe "when user_id is not presented" do
  	before {@micropost.user_id= nil}
  	it {should_not be_valid }
  	
  end
end
