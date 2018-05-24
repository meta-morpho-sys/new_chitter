# frozen_string_literal: true

# Controller for Peeps path
class Chitter < Sinatra::Base
  get '/user/:id/peeps' do
    @peeps = Peep.find(1)
    erb :'peeps/index'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  post '/peeps' do
    Peep.create(session[:user_id], params[:text])
    redirect '/peeps/index'
  end
end
