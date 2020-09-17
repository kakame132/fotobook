class Admins::AlbumsController < ApplicationController
  before_action :check_admin

  def index
    @albums=Album.all.order(updated_at: :desc).page(params[:page]).per(12)
  end

  def edit
    if current_user.admin == false
      @album=current_user.albums.find(params[:id])
    else
      @album=Album.find(params[:id])
    end
    @photo=current_user.photos.new()
  end


  def update
    @album=Album.find(params[:id])
    @photo =@album.photos.new(photo_params)
    unless @photo.image_url.nil?
      @photo.user_id=@album.user_id
      @photo.save
    end
      # @album = current_user.albums.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to edit_admins_album_path(id: @album.id)
    else
      redirect_to edit_admins_album_path(id: @album.id)
    end
  end


  def destroy
      if Album.destroy(params[:id])
        redirect_to admin_manage_album_path(current_user.id)
      else
        redirect_to action: :edit
      end
  end




  private
      def photo_params
        params.require(:photo).permit(:title, :description, :image,:public)
      end

      def album_params
        params.require(:photo).permit(:title, :description, :public)
      end

      def check_admin
        unless current_user.admin?
            redirect_to user_path(current_user.id)
        end
      end
end
