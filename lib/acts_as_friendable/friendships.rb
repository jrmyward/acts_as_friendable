module ActsAsFriendable
  class Friendship < ActiveRecord::Base
    attr_accessible :approved, :friend_id, :user_id
  end
end