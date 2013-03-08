require 'spec_helper'

describe ActsAsFriendable do
  let(:user) { User.create!({ first_name: 'James', last_name: 'Bond' }) }

  describe "Reciever" do
    it "should respond to friendships" do
      user.should respond_to(:friendships)
    end

    it "should respond to inverse_friendships" do
      user.should respond_to(:inverse_friendships)
    end

    it "should respond to direct_friends" do
      user.should respond_to(:direct_friends)
    end

    it "should respond to inverse_friends" do
      user.should respond_to(:inverse_friends)
    end

    it "should respond to pending_friends" do
      user.should respond_to(:pending_friends)
    end

    it "should respond to requested_friendships" do
      user.should respond_to(:requested_friendships)
    end
  end
  
end