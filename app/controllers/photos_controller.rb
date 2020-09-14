class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
   @photo = Photo.order('created_at DESC')
  end


  def new
    @photo=current_user.photos.new()
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      redirect_to user_path(current_user.id)
    else
      redirect_to action: :new
    end
  end

  def edit
    if current_user.admin == false
      @photo=current_user.photos.find(params[:id])
    else
      @photo=Photo.find(params[:id])
    end
    render :edit
  end


  def update
    if current_user.admin == false
      @photo = current_user.photos.find(params[:id])
    else
      @photo=Photo.find(params[:id])
    end
    if @photo.update_attributes(photo_params)
      if current_user.admin == true
        redirect_to admin_manage_photo_path(current_user.id)
      else
        redirect_to user_path(current_user.id)
      end
    else
      render :edit
    end
  end


  def destroy
    if current_user.admin==true
      if Photo.destroy(params[:id])
        redirect_to admin_manage_photo_path(current_user.id)
      else
        redirect_to action: :edit
      end
    else
      if current_user.photos.find(params[:id]).album_id.nil?
        if current_user.photos.destroy(params[:id])
          redirect_to user_path(current_user.id)
        else
          redirect_to action: :edit
        end
      else
        @c=current_user.photos.find(params[:id]).album_id
        current_user.photos.destroy(params[:id])
        redirect_to edit_album_path(id: @c)
      end
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :image,:public)
  end

end
