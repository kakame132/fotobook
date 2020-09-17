module HomeHelper
  def followed?(user1,user2)
    if user1.followings.find(user2.id)
      return true
    else
      return false
    end
  end
end
