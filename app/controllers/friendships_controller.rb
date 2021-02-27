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
    current_user.confirm_friend(friend)
    redirect_to current_user
  end

  def reject_request
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: friendship_params[:friend_id])
    if friendship
      friendship.destroy
      redirect_to current_user
    else
      friendship = Friendship.find_by(user_id: friendship_params[:friend_id], friend_id: current_user.id)
      if friendship
        friendship.destroy
        redirect_to current_user
      else 
        redirect_to root_path
      end 
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
