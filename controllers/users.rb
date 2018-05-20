# frozen_string_literal: true

# Controller for path of creating users
class Chitter < Sinatra::Base
  # <editor-fold desc="SIGN UP">
  get '/login/sign_up' do
    erb :'login/sign_up'
  end

  post '/login/sign_up' do
    begin
      user = User.create(params[:name], params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = FlashMsgs::WELCOME.call(user.name)
    rescue Sequel::UniqueConstraintViolation
      flash[:error] = FlashMsgs::DUPLICATE_EMAIL
      redirect '/login/sign_up'
    end
    redirect "user/#{user.id}/peeps"
  end
  # </editor-fold>
end
