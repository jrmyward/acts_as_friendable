require "active_record"
require "active_record/version"
require "acts_as_friendable/model_additions"
require "acts_as_friendable/friendships"
require "acts_as_friendable/version"

module ActsAsFriendable
  def self.included(receiver)
    receiver.class_eval do
      has_many :friendships, :class_name => "ActsAsFriendable::Friendship", :dependent => :destroy
    end
    # ActsAsFriendable::Friendship.class_eval %Q{
    #   belongs_to :#{receiver.to_s.underscore}, :class_name => "#{receiver.to_s}", :foreign_key => "user_id"
    #   belongs_to :friend, :class_name => "#{receiver.to_s}", :foreign_key => "friend_id"
    # }

    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
