module UsersHelper
  def followed?(user1,user2)
     user1.followings.find_by(id: user2)
  end

  def liked? (user, post)
    post.likes.find_by(user_id: user)
  end
end
