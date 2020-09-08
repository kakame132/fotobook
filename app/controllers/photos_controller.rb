class PhotosController < ApplicationController
  before_action :authenticate_user!
  def index
   @photo = Photo.order('created_at DESC')
  end
  def new
    @photo=Photo.new
    @user = User.find_by(id: user_info)
  end

  def create
    @photo = Photo.new photo_params
    @photo.user_id = user_info
    if @photo.save
      redirect_to action: :new
    else
      redirect_to action: :new
    end
  end

  def edit
    @photo=Photo.find(params[:id])
    render :edit
  end

  def update

    @photo = Photo.find(params[:id])
    if @photo.update_attributes(photo_params)
      redirect_to
    else
      render :edit
    end
  end
  private
  def user_info
      params.require(:user_id)
    end
  def photo_params
    params.require(:photo).permit(:title, :description, :image,:public)
  end
end
