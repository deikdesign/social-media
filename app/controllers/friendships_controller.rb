class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def friend_request
    current_user.friendships.create!(friendship_params)
    if current_user.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  def accept_request
    value = friendship_params[:friend_id]
    friend = User.find(value)
    friendship = friend.friendships.find_by(friend_id: current_user.id)
    if current_user.friend_requests.include?(friend)
      friendship.confirm_friend
      redirect_to current_user
    else
      redirect_to root_path
    end
  
    
  end

  def reject_request
    friend = User.find(friendship_params[:friend_id])
    friendship = Friendship.find_by(friend_id: current_user.id)
    if friendship
      friendship.destroy
      redirect_to current_user
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
