class HomeController < ApplicationController
  before_action :authenticate_user!, :except => [:guestfeed]
  def guestfeed
    if(user_signed_in?)
      if current_user.admin == true
        redirect_to admin_manage_photo_path(current_user.id)
      else
        redirect_to :feed
      end
    else
      render 'guestfeed'
    end
  end


  def newest
    @a= Album.order(created_at: :desc).limit(4)
    @c=0
    render 'newest'
  end
  def feed
    @u=current_user
    @p=current_user.followings.map { |user| user.photos.all.where(public:true).order(created_at: :desc) }.flatten!
    @a=current_user.followings.map { |user| user.albums.all.where(public:true).order(created_at: :desc) }.flatten!
    render 'feed'
  end

  def discover
    @u=current_user
    @p=Photo.order(created_at: :desc).limit(6)
    @a=Album.order(created_at: :desc).limit(6)
    # @l=User.find_by(id:1)
    render 'discover'
  end
end
