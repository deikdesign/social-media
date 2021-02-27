require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Friend Helper Functions' do
    it 'Checks if user has no friends' do
      user = User.new
      expect(user.friends.empty?).to eq(true)
    end
    it 'Checks if user has pending friend requests' do
      user = User.new({ email: 'john@noemail.com' })
      user2 = User.new({ email: 'fred@noemail.com' })
      user.save(validate: false)
      user2.save(validate: false)
      user.friendships.create({ friend_id: user2.id })
      expect(user.pending_friends.empty?).to eq(false)
    end
    it 'Checks if user has friends' do
      user = User.new({ email: 'john@noemail.com' })
      user2 = User.new({ email: 'fred@noemail.com' })
      user.save(validate: false)
      user2.save(validate: false)
      user.friendships.create({ friend_id: user2.id })
      user2.confirm_friend(user)
      expect(user.friends.empty?).to eq(false)
    end
    it 'Checks if two different users are friends' do
      user = User.new({ email: 'john@noemail.com' })
      user2 = User.new({ email: 'fred@noemail.com' })
      user.save(validate: false)
      user2.save(validate: false)
      user.friendships.create({ friend_id: user2.id })
      user2.confirm_friend(user)
      expect(user.friend?(user2)).to eq(true)
    end
  end

  context 'Making Posts' do
    it 'Creates a post for a user' do
      user = User.new({ email: 'john@noemail.com' })
      user.save(validate: false)
      user.posts.create({ content: 'This is a test' })
      expect(user.posts.empty?).to eq(false)
    end
  end

  context 'Liking Posts' do
    it 'Like a post' do
      user = User.new({ email: 'john@noemail.com' })
      user.save(validate: false)
      post = user.posts.create({ content: 'This is a test' })
      user.likes.new({ post_id: post.id })

      expect(user.likes.empty?).to eq(false)
    end
  end
end
