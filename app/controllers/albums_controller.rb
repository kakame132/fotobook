class AlbumsController < ApplicationController
  def index
   @albums = Album.order('created_at DESC')
  end


  def new
    @photo=current_user.photos.new()
  end

  def create
    @album =current_user.albums.new(album_params)
    if @album.save
      @photo =@album.photos.new(photo_params)
      @photo.user_id=current_user.id
      if @photo.save
        redirect_to edit_album_path(id: @album.id)
      else
        redirect_to action: :new
      end
    else
      redirect_to action: :new
    end
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
    @album = current_user.albums.find(params[:id])
    @photo =@album.photos.new(photo_params)
    unless @photo.image_url.nil?
      @photo.user_id=@album.user_id
      @photo.save
    end
      # @album = current_user.albums.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to edit_album_path(id: @album.id)
    else
      redirect_to edit_album_path(id: @album.id)
    end
  end


  def destroy
    if current_user.admin==true
      if Album.destroy(params[:id])
        redirect_to admin_manage_album_path(current_user.id)
      else
        redirect_to action: :edit
      end
    else
      if current_user.albums.destroy(params[:id])
        redirect_to user_path(current_user.id)
      else
        redirect_to action: :edit
      end
    end
  end


  private
  def photo_params
    params.require(:photo).permit(:title, :description, :image,:public)
  end
  def album_params
    params.require(:photo).permit(:title, :description, :public)
  end
end
