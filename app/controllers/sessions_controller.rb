class SessionsController < ApplicationController

  def new
    redirect_to '/auth/namely'
  end


  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      session[:code] = params['code']

      flash[:success] = "Welcome, #{@user.name}!"
    rescue
      flash[:warning] = "Unable to Authenticate"
   end
    redirect_to employees_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_url
  end

  def auth_failure
    redirect_to root_path
  end

end
