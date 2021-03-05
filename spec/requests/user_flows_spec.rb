require 'rails_helper'

RSpec.describe "UserFlows", type: :request do
  describe "Post friend requests" do
    it "send friend request" do
      post friend_request_path,
        params: {user: {id: "2"}}
        assert_response :redirect
        follow_redirect!
        assert_response :success
    end 
    it "accept friend request" do
      post accept_request_path,
        params: {user: {id: "2"}}
        assert_response :redirect
        follow_redirect!
        assert_response :success
    end
  end
  describe "make posts" do
    it "creates a post" do
     post '/posts',
      params: {post: {content: "Tester TExt"}}
      assert_response :redirect
      follow_redirect!
      assert_response :success
    end
  end
end
