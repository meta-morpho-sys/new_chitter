# frozen_string_literal: true

# Controller for Peeps path
class Chitter < Sinatra::Base
  get '/user/:id/peeps' do
    @peeps = Peep.all_per(current_user.id)
    erb :'peeps/index'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  post '/peeps' do
    Peep.create(user_id: current_user.id, text: params[:text])
    redirect '/user/:id/peeps'
  end
end
