module FriendshipsHelper
    def mutual_friends(user)
        mutual = current_user.friends & user.friends
        return if mutual.empty?

        mutual.map(&:name).join(', ')
    end 
    
    def relevant_post(post)
        if current_user.friends.include?(post.user) or post.user == current_user then return true
        else return false end
    end
end
