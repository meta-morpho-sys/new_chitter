# frozen_string_literal: true

# Server
class Chitter < Sinatra::Base

  helpers AppHelpers
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(20) }
  set :public_folder, (proc { File.join(root, 'static') })
  configure :development do
    enable :logging
  end
  register Sinatra::Flash

  before do
    if invalid_user_session? && !logging_in?
      flash[:error] = FlashMsgs::LOGIN_REQUIRED
      redirect '/login/home'
    end
  end

  # <editor-fold desc="HOME">
  get '/' do
    logger.info('SINATRA LOGGER')
    redirect '/login/home'
  end

  get '/login/home' do
    logger.info('SINATRA LOGGER /login/home')
    @peeps = Peep.all
    erb :'login/home'
  end
  # </editor-fold>

  run! if app_file == $PROGRAM_NAME
end
