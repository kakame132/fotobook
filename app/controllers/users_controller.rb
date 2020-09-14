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



  def show
    if( params[:id] == current_user.id.to_s)
      @u = current_user
      render "my_profile"
    else
      @u = User.where(id: params[:id]).first
      render "public_profile"
    end
  end
  private
    def user_detail
      params.require(:user).permit(:last_name, :first_name, :password, :email,:image)
    end
end
