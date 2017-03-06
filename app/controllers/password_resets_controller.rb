class PasswordResetsController < ApplicationController
  before_action :get_user, only:[:edit, :update]
  before_action :validate_user, only:[:edit, :update]
  before_action :check_expiration, only:[:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "please check your email to reset password"
      redirect_to root_url
    else
      flash.now[:danger] = "User does not exist"
      render 'new'
    end
  end

  def edit

  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "Can't be empty")
        render 'edit'
    elsif @user.update_attributes(user_params)
      flash[:success] = "Password successfully updated"
      @user.update_attribute(:reset_digest, nil)
      redirect_to login_url
    else
      render 'edit'
    end
  end


  private
  def get_user
    @user = User.find_by(email: params[:email])
  end

  def validate_user
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Link has expired"
      redirect_to new_password_reset_url
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end