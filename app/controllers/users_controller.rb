class UsersController < ApplicationController

  def new
  end
  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to duct_lines_path, notice: "Login successful!"
    else
      flash.now[:alert] = "Invalid username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out successfully!"
  end

  private 

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
