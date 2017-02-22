class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_columns(activated: true, activated_at: Time.zone.now)
      log_in(user)
      flash[:success] = "#{user.name}, your account is activated!"
      redirect_to user
    else
      flash[:error] = "invalid confirmation link"
      redirect_to root_url
    end
  end
end
