class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendship = Friendship.new
    @users = User.all
  end

  def show
    @friendship = Friendship.new
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  private

  def mutual_friends(user)
    current_user.friends & user.friends
  end
end
