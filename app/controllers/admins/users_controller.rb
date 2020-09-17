class Admins::UsersController < ApplicationController
  before_action :check_admin

  def index
    @users=User.all.order(updated_at: :desc).page(params[:page]).per(12)
  end


  def edit
      @user=User.where(id: params[:id]).first
  end

  def update
      @user=User.where(id: params[:id]).first
      puts params[:user][:active]
      if params[:user][:active] == '0'
        puts 999999999999999
        UserMailer.inactive_email(@user).deliver_now
      else
        puts 100000000000000000
      end
      if params[:user][:password].blank?
        if @user.update_without_password(user_params)
          redirect_to admins_users_path
        else
          render :edit
        end
      else
        if @user.update(user_params)
          redirect_to admins_users_path
        else
          render :edit
        end
      end
  end

  def destroy
      @user=User.where(id: params[:id]).first
      if @user.destroy
        redirect_to admins_users_path, notice: "User delete"
      else
        redirect_to admins_users_path, notice: "Failed"
      end
  end


  private

        def user_params
            params.require(:user).permit(:first_name, :last_name, :image, :password, :active)
        end

        def check_admin
            unless current_user.admin?
               redirect_to user_path(current_user.id)
            end
        end
end
