require 'spec_helper'

describe ActsAsFriendable::Friendship do
  let(:user) { User.create!({ first_name: 'James', last_name: 'Bond' }) }

  it "should respond to user" do
    ActsAsFriendable::Friendship.instance_methods.include?(:user).should be_true
  end

  it "should respond to friend" do
    ActsAsFriendable::Friendship.instance_methods.include?(:friend).should be_true
  end

end