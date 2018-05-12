# frozen_string_literal: true

# Controller
class Chitter < Sinatra::Base
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(20) }
  register Sinatra::Flash

  get '/' do
    'lets start'
  end

  run! if app_file == $PROGRAM_NAME
end
