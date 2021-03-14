module FriendshipsHelper
  def mutual_friends(user)
    mutual = current_user.friends & user.friends
    return if mutual.empty?

    mutual.map(&:name).join(', ')
  end

  def relevant_post(post)
    if current_user.friends.include?(post.user) or post.user == current_user then true
    else false end
  end

  def friends?(user)
    if current_user.friend?(user)
      content_tag(:p, 'Already Friends!')
    elsif current_user.pending_friends.include?(user)
      content_tag(:p, 'Friend Request Pending')
    elsif current_user.friend_requests.include?(user)
      render partial: 'users/accept_request'
    else
      render partial: 'users/send_request'
    end
  end

  def incoming_requests
    unless current_user.friend_requests.empty?
      tag = content_tag(:h3, 'Friend requests: ')
      current_user.friend_requests.each do |request|
        tag += render partial: 'users/incoming_requests', locals: { request: request }
      end
    end
    tag
  end
end
