class UsersController < ApplicationController
  def new
    @name = "Signup"
    @user = User.new
  end

  def destroy

  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Hi #{@user.name}, welcome to the sample app!"
      redirect_to @user
      log_in(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
