# frozen_string_literal: true

# Server
class Chitter < Sinatra::Base
  helpers AppHelpers
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(20) }
  register Sinatra::Flash

  before do
    # redirect '/login/home' if valid_user_session? && !logging_in?
    redirect '/login/home' if invalid_user_session?
  end

  # <editor-fold desc="HOME">
  get '/' do
    redirect '/login/home'
  end

  get '/login/home' do
    erb :home
  end
  # </editor-fold>

  run! if app_file == $PROGRAM_NAME
end
