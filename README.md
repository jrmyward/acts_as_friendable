# ActsAsFriendable [![Build Status](https://travis-ci.org/jrmyward/acts_as_friendable.png?branch=master)](https://travis-ci.org/jrmyward/acts_as_friendable)

ActsAsFriendable provides a Friendship model, relevent scopes, and many instance methods to quickly and easily add Social Networking functionality to your Rails application.

## Overview

ActsAsFriendable defines a "friendship" as a two-way relationship which is initiated by one user and approved by the other user. So, we have two states of a friendship (not-approved-yet or approved) and we have two directions of friendship relative to the current user: friendships requested by the current user (we’ll call these “direct” friendships), and friendships requested to the current user (we’ll call these “inverse” friendships).

## Installation

Add ActsAsFriendable to your Gemfile:

```ruby
 gem 'acts_as_friendable'
```

And then install it with bundler by executing:

```shell
bundle install
```

Install and run the migrations:

```shell
rails g acts_as_friendable:install
rake db:migrate
```

## Usage

ActsAsFriendable is meant to be used on one Active Record model. The model can be named anything you like, but it will most frequently be 'User'. **Note:** you'll need to manually add ActsAsFriendable to your model class.

```ruby
class User < ActiveRecord::Base
  include ActsAsFriendable
end
```

`include ActsAsFriendable` adds all of the ActsAsFriendable goodness to the model.

### Scopes and Methods

Given the "friendship" definition in the Overview, we have 4 possible states of Friendship:

1. direct approved
2. indirect approved
3. direct not-approved
4. indirect not-approved

States #1 and #2 are simply what we will be calling "friends." They are approved relationships, no matter the direction. Because we don’t care who requested the friendship once it’s approved, we will group these together.

State #3 is what we call "pending friends." Other users with whom the current user has requested to be friends and are awaiting approval. These are out of of the control of the current user and just waiting to be approved or rejected.

State #4 is what we call "requested friends." Other users who have requested that the current user be their friend and are awaiting the approval of the current user. These are the actionable items for the current user to approve or reject. Ignoring a friend request simply deletes the non-approved Friendship (similar to Facebook). It doesn't tell the the other person they were reject but allows them to send another friend request if they want.

With that understanding we have the following scopes / "lookup" methods available to us:

```ruby
class User < ActiveRecord::Base
  include ActsAsFriendable
end

@user = User.find(1) # assuming there is a user in the database

@user.friendships
@user.inverse_friendships
@user.direct_friends
@user.inverse_friends
@user.pending_friends
@user.requested_friendships
@user.friends # => amalgamation of direct_friends and inverse_friends

# Additionally, we have several convenience methods to help in sorting, listing, finding, etc.

 # provides a map of the current user's friend's ids
@user.friend_ids

# provides a map of ids of all current and requested friends of the current user
#   - useful in querying for new friends
@user.pending_and_friend_ids

# includes the current user's id in the map of friend's ids
#   - useful when you need to inlude the current user in a collection (Activities, Comments, Leaderboards, etc.)
@user.friend_ids_and_me


```

## Testing

ActsAsFriendable uses RSpec for its test coverage. Inside the gem directory, you can run the specs with:

```shell
bundle exec rake
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
