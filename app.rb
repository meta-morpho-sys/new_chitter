# frozen_string_literal: true

require 'sinatra'
require 'sinatra/flash'
require './db/sequel_setup'
require_relative './models/user'
require_relative './lib/flash_msgs'

# Controller
class Chitter < Sinatra::Base
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(20) }
  register Sinatra::Flash

  before do
    if request.path_info.split('/')[1] != 'login' && session[:user_id].nil?
      redirect '/login/home'
    end
    @user = User.find(session[:user_id])
  end

  # <editor-fold desc="HOME">
  get '/' do
    redirect '/login/home'
  end

  get '/login/home' do
    erb :home
  end
  # </editor-fold>

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

  # <editor-fold desc="SIGN IN">
  get '/login/sign_in' do
    erb :'/login/sign_in'
  end

  post '/login/sign_in' do
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

  # <editor-fold desc="SIGN OUT">
  post '/login/sign_out' do
    session.clear
    flash[:notice] = FlashMsgs::SIGN_OUT
    redirect '/home'
  end
  # </editor-fold>

  get '/user/:id/peeps' do
    @user = User.find params[:id]
    erb :'peeps/index'
  end

  run! if app_file == $PROGRAM_NAME
end
