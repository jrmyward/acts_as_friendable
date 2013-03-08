require "active_record"
require "active_record/version"
require "acts_as_friendable/model_additions"
require "acts_as_friendable/friendships"
require "acts_as_friendable/version"

module ActsAsFriendable
  def self.included(receiver)
    receiver.class_eval do
      has_many :friendships, :class_name => "ActsAsFriendable::Friendship", :dependent => :destroy
      has_many :inverse_friendships, :class_name => "ActsAsFriendable::Friendship", :foreign_key => "friend_id", :dependent => :destroy
      has_many :direct_friends, :through => :friendships, :conditions => "approved = true", :source => :friend
      has_many :inverse_friends, :through => :inverse_friendships, :conditions => "approved = true", :source => :user
      has_many :pending_friends, :through => :friendships, :conditions => "approved = false", :source => :friend
      has_many :requested_friendships, :class_name => "ActsAsFriendable::Friendship", :foreign_key => "friend_id", :conditions => "approved = false"
    end

    ActsAsFriendable::Friendship.class_eval do
      belongs_to "#{receiver.to_s.underscore}".to_sym, :class_name => "#{receiver.to_s}", :foreign_key => "user_id"
      belongs_to :friend, :class_name => "#{receiver.to_s}", :foreign_key => "friend_id"
    end

    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
