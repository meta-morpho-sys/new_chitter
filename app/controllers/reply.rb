# frozen_string_literal: true

# Controller for path to handling replies
class Chitter < Sinatra::Base
  get '/peeps/:id/reply' do
    @peep = Peep.find(params[:id])
    erb :'replies/new'
  end

  post '/replies' do
    p_id = params[:peep_id]
    u_id = current_user.id
    text = params[:text]
    Reply.create(peep_id: p_id, user_id: u_id, text: text, created_at: Time.now)
    redirect '/'
  end
end
