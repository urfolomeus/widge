class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :root, notice: 'Please click the link in the activation email we have just sent in order to continue.'
    else
      render :new
    end
  end

  # def activate
  #
  # end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
