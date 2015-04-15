module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def current_user
    User.find_by_id session[:user_id]
  end
end
