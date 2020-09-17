class Admins::PhotosController < ApplicationController
  before_action :check_admin

  def index
    @photos=Photo.all.order(updated_at: :desc).page(params[:page]).per(12)
  end

  def edit
    @photo=Photo.find(params[:id])
  end


  def update
    @photo=Photo.find(params[:id])
    if @photo.update_attributes(photo_params)
      redirect_to admins_photos_path(current_user.id)
    else
      render :edit
    end
  end


  def destroy
    if Photo.find(params[:id]).album_id.nil?
      if Photo.destroy(params[:id])
        redirect_to admins_photos_path
      else
        redirect_to action: :edit
      end
    else
      @c=Photo.find(params[:id]).album_id
      Photo.destroy(params[:id])
      redirect_to edit_admins_album_path(id: @c)
    end
  end

  private
       def check_admin
           unless current_user.admin?
               redirect_to user_path(current_user.id)
           end
       end

       def photo_params
         params.require(:photo).permit(:title, :description, :image,:public)
       end
end
