# frozen_string_literal: true

# Controllers for path to sign in and sign out
class Chitter < Sinatra::Base

  # <editor-fold desc="SIGN IN">
  get '/login/sign_in' do
    erb :'/login/sign_in'
  end

  post '/login/sign_in' do
    unless User.exists?(params[:email])
      flash[:notice] = FlashMsgs::NO_SUCH_USER
      redirect '/login/sign_in'
    end
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = FlashMsgs::WELCOME_BACK.call(user.name)
      redirect "user/#{user.id}/peeps"
    else
      flash[:notice] = FlashMsgs::WRONG_ACCESS_CREDENTIALS
      redirect '/login/sign_in'
    end
  end
  # </editor-fold>

  #   # <editor-fold desc="SIGN OUT">
  post '/login/sign_out' do
    session.clear
    flash[:notice] = FlashMsgs::SIGN_OUT
    redirect '/home'
  end
  # </editor-fold>
end
