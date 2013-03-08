require 'spec_helper'

describe ActsAsFriendable do
  let(:user) { User.create!({ first_name: 'James', last_name: 'Bond' }) }

  describe "Reciever" do
    it "should respond to is_friendable" do
      User.methods.include?(:acts_as_friendable)
    end
  end
  
end