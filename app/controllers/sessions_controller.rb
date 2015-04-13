class SessionsController < ApplicationController
  # GET /sessions/new
  def new
    @user = User.new
  end

  # POST /sessions
  def create
    @user = User.where(user_params).first
    respond_to do |format|
      if @user.authenticate params[:user][:password]
        sign_in @user
        format.html { redirect_to users_url }
      else
        format.html { redirect_to users_url }
      end
    end
  end

  def destroy
    sign_out
    @user = User.new
    respond_to { |format| format.html { render :new } }
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
