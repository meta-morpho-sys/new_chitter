# frozen_string_literal: true

require 'sinatra'
require 'sinatra/flash'
require './db/sequel_setup'
require_relative './lib/flash_msgs'

# Controller
class Chitter < Sinatra::Base
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(20) }
  register Sinatra::Flash

  # <editor-fold desc="HOME">
  get '/' do
    redirect 'login/home'
  end

  get '/login/home' do
    erb :home
  end
  # </editor-fold>

  get '/login/users/new/' do
    erb :'users/new'
  end

  post '/login/users' do
    begin
      user = User.create(params[:email], params[:password])
      session[:user_id] = user.id
    rescue Sequel::UniqueConstraintViolation
      flash[:error] = FlashMsgs::DUPLICATE_EMAIL
      redirect '/login/users/new/'
    end
    redirect "user/#{user.id}/peeps"
  end

  run! if app_file == $PROGRAM_NAME
end
