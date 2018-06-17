# frozen_string_literal: true

# Controller for Peeps path
class Chitter < Sinatra::Base
  get '/user/:id/peeps' do
    @peeps = Peep.per_user(current_user.id)
    erb :'peeps/index'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  post '/peeps' do
    # TODO: handle the Not Null constraint exception
    Peep.create(user_id: current_user.id, text: params[:text], created_at: Time.now)
    redirect '/user/:id/peeps'
  end
end
