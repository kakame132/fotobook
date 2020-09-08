class HomeController < ApplicationController
  before_action :authenticate_user!, :except => [:guestfeed]
  def guestfeed
    render 'guestfeed'
  end

  def newest
    @a= Album.order(created_at: :desc).limit(4)
    @c=0
    render 'newest'
  end
  def feed
    @u=User.find_by(id:2)
    @p=Photo.order(created_at: :desc).limit(6)
    @a=Album.order(created_at: :desc).limit(6)
    render 'feed'
  end
  
  def discover
    @u=User.find_by(id:2)
    @p=Photo.order(created_at: :desc).limit(6)
    @a=Album.order(created_at: :desc).limit(6)
    # @l=User.find_by(id:1)
    render 'discover'
  end
end
