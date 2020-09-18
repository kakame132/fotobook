class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new user_detail

    if @user.save
      UserMailer.sample_email(@user).deliver_now
      flash[:success] = "User was successfully created."
      redirect_to action: :new
    else
      flash[:error] = @user.errors.full_messages[0]
      redirect_to action: :new
    end
  end


  def edit
    if current_user.admin== true
      @u=User.where(id: params[:id]).first
      render "admins/manage_user_profile"
    else
      redirect_to edit_user_registration_path
    end
  end


  def follow
        @user = User.find(follow_user)
        follow = Follow.find_by(follower_id:current_user, followed_user_id:@user)
        if follow
            follow.destroy
        else
            current_user.followings << @user
        end
        render 'follow.js.erb'
  end


  def like
      like_rec = Like.find_by(like_post)
      if like_rec
        if like_post[:likeable_type] == "Photo"
          @photo=Photo.where(id: like_post[:likeable_id]).first
          @photo.like_count -=1
          @photo.save
        end
        if like_post[:likeable_type] == "Album"
          @album=Album.where(id: like_post[:likeable_id]).first
          @album.like_count -=1
          @album.save
        end
        like_rec.destroy

      else
        if like_post[:likeable_type] == "Photo"
          @photo=Photo.where(id: like_post[:likeable_id]).first
          @photo.like_count +=1
          @photo.save
        end

        if like_post[:likeable_type] == "Album"
          @album=Album.where(id: like_post[:likeable_id]).first
          @album.like_count +=1
          @album.save
        end
        Like.create(like_post)
      end
      render 'like.js.erb'
    end


  def get_album
     photos = Album.find(params[:content_id]).photos
     html = String.new
     i=0
     photos.each do |p|
       if i==0
         html += '<div class="carousel-item active"><img src="'+ p.image.url + '" class="d-block w-100"></div>'
         i+=1
       else
         html += '<div class="carousel-item"><img src="'+ p.image.url + '" class="d-block w-100"></div>'
       end
     end

     puts html
     render :js => html
   end


  def show
    if( params[:id] == current_user.id.to_s)
      @photos = current_user.photos.where(album_id: nil).order(updated_at: :desc)
      @albums = current_user.albums.order(updated_at: :desc)
      render "my_profile"
    else
      @user = User.where(id: params[:id]).first
      @photos = @user.photos.where(album_id: nil,public:true).order(updated_at: :desc)
      @albums = @user.albums.where(public:true).order(updated_at: :desc)
      render "public_profile"
    end
  end


  private
    def like_post
      { :likeable_type => params.require(:type), :likeable_id => params.require(:post_id), :user_id => params.require(:user_id) }
    end


    def follow_user
      params.require(:followed_user_id)
    end


    def user_detail
      params.require(:user).permit(:last_name, :first_name, :password, :email,:image)
    end
end
