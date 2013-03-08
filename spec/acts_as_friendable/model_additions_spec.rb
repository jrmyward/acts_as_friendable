require 'spec_helper'

describe ActsAsFriendable do
  let(:user) { User.create!({ first_name: 'Bruce', last_name: 'Wayne' }) }
  let(:user_2) { User.create!({ first_name: 'Clark', last_name: 'Kent' }) }
  let(:user_3) { User.create!({ first_name: 'Peter', last_name: 'Parker' }) }
  let(:user_4) { User.create!({ first_name: 'Bruce', last_name: 'Banner' }) }
  let(:user_5) { User.create!({ first_name: 'Tony', last_name: 'Stark' }) }

  before(:each) do
    ActsAsFriendable::Friendship.create({user_id: user.id, friend_id: user_2.id, approved: true})
    ActsAsFriendable::Friendship.create({user_id: user_3.id, friend_id: user.id, approved: true})
    ActsAsFriendable::Friendship.create({user_id: user_4.id, friend_id: user.id, approved: false})
    ActsAsFriendable::Friendship.create({user_id: user.id, friend_id: user_5.id, approved: false})
  end

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

  describe "Scope" do

    describe "friendships" do
      it "collects all user-initiated relationships" do
        r = user.friendships
        r[0].friend_id.should == user_2.id
      end
    end

    describe "inverse_friendships" do
      it "collects all stranger-initiated relationships" do
        r = user.inverse_friendships
        r[0].user_id.should == user_3.id
      end
    end

    describe "direct_friends" do
      it "collects approved user-initiated relationships" do
        r = user.direct_friends
        r[0].id.should == user_2.id
      end
    end

    describe "inverse_friends" do
      it "collects approved stranger-initiated relationships" do
        r = user.inverse_friends
        r[0].id.should == user_3.id
      end
    end

    describe "pending_friends" do
      it "collects un-approved user-initiated relationships" do
        r = user_4.pending_friends
        r[0].id.should == user.id
      end
    end

    describe "requested_friendships" do
      it "collects un-approved stranger-initiated relationships" do
        r = user.requested_friendships
        r[0].id.should == user_4.id
      end
    end

    describe "friends" do
      it "collects a user's approved direct_friends and inverse_friends" do
        r = user.friends
        r[0].id.should == user_2.id
        r[1].id.should == user_3.id
      end
    end
  end

  describe "Instance Method" do

    describe "friend_ids" do
      it "should return an array of all direct_friends and inverse_friends ids" do
        user.friend_ids.include?(user_2.id).should be_true
        user.friend_ids.include?(user_5.id).should be_false
      end
    end

    describe "friend_ids_and_me" do
      it "should return an array of approved friend ids plus the current user's id" do
        user_3.friend_ids_and_me.should == [user.id, user_3.id]
      end
    end

    describe "pending_and_friend_ids" do
      it "should return an array of all approved friends and user-initiated pending friends" do
        user.pending_and_friend_ids.include?(user_2.id).should be_true
        user.pending_and_friend_ids.include?(user_5.id).should be_true
      end
    end

  end

end