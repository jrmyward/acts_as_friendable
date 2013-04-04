module ActsAsFriendable
  extend ActiveSupport::Concern

  module ClassMethods

  end

  def friends
    direct_friends | inverse_friends
  end

  def friend_ids
    friends.map {|f| f.id}
  end

  def friend_ids_and_me
    friend_ids << id
  end

  def pending_and_friend_ids
    pending_and_friend_ids = []
    pending_and_friend_ids << friend_ids
    pending_and_friend_ids << pending_friends.map {|f| f.id}
    pending_and_friend_ids.flatten
  end

end