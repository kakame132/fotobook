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
  def show
    if( params[:id] == current_user.id.to_s)
      @u = User.find(params[:id])
      render "my_profile"
    else
      @u = User.find(params[:id])
      render "public_profile"
    end
  end
  private
    def user_detail
      params.require(:user).permit(:last_name, :first_name, :password, :email)
    end
end
