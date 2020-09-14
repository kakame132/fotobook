class AdminsController < ApplicationController
  before_action :check_admin
  # def show
  #   redirect_to admin_manage_photo_path(admin_id: current_user.id)
  # end
  def manage_photo
      @p=Photo.all.order(updated_at: :desc).limit(20)
      render 'manage_photo'
  end

  def manage_album
    @a=Album.all.order(updated_at: :desc).limit(20)
    render 'manage_album'
  end

  def manage_user
    @u=User.all.limit(10)
    render 'manage_user'
  end

  private
       def check_admin
           unless current_user.admin?
               redirect_to user_path(current_user.id)
           end
       end
end
