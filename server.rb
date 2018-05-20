# frozen_string_literal: true
#
# Server
class Chitter < Sinatra::Base
  helpers Helpers
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(20) }
  register Sinatra::Flash

  before do
    redirect '/login/home' if valid_user_session?
    current_user
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
