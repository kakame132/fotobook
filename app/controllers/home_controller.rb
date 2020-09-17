class HomeController < ApplicationController
  before_action :authenticate_user!, :except => [:guestfeed]
  def guestfeed
    if(user_signed_in?)
      if current_user.admin == true
        redirect_to admins_photos_path
      else
        redirect_to :feed
      end
    else
      @photos=Photo.all.where(public: true).order(created_at: :desc).page(params[:page]).per(6)
      @albums=Album.all.where(public: true).order(created_at: :desc).page(params[:page]).per(6)
      render 'guestfeed'
    end
  end


  def newest
    @a= Album.order(created_at: :desc).limit(4)
    @c=0
    render 'newest'
  end


  def feed
    @photos=Photo.where(user_id: current_user.followings.ids,public: true).order(created_at: :desc).page(params[:page]).per(6)
    @albums=Album.where(user_id: current_user.followings.ids,public: true).order(created_at: :desc).page(params[:page]).per(6)
    render 'feed'
  end


  def discover
    @photos=Photo.all.where(public: true).order(created_at: :desc).page(params[:page]).per(6)
    @albums=Album.all.where(public: true).order(created_at: :desc).page(params[:page]).per(6)
    # @l=User.find_by(id:1)
    render 'discover'
  end
end
