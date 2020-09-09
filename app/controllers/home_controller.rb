class HomeController < ApplicationController
  before_action :authenticate_user!, :except => [:guestfeed]
  def guestfeed
    if(user_signed_in?)
      redirect_to :feed
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
    @u=User.find(current_user.id)
    @p=Photo.order(created_at: :desc).limit(6)
    @a=Album.order(created_at: :desc).limit(6)
    render 'feed'
  end

  def discover
    @u=User.find(current_user.id)
    @p=Photo.order(created_at: :desc).limit(6)
    @a=Album.order(created_at: :desc).limit(6)
    # @l=User.find_by(id:1)
    render 'discover'
  end
end
