require 'spec_helper'

describe ActsAsFriendable do
  let(:user) { User.create!({ first_name: 'James', last_name: 'Bond' }) }

  describe "Reciever" do
    it "should respond to friendships" do
      user.should respond_to(:friendships)
    end
  end
  
end