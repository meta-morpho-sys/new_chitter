# frozen_string_literal: true

# Controller for path to handling replies
class Chitter < Sinatra::Base
  get '/peeps/:id/reply' do
    begin
      @peep = Peep.with_pk!(params[:id])
    rescue Sequel::NoMatchingRow
      flash[:notice] = FlashMsgs::NO_PEEP_FOUND
      redirect '/'
    end
    erb :'replies/new'

  end

  post '/replies' do
    p_id, text, u_id = reply_params
    # TODO: handle the Not Null constraint exception
    Reply.create(peep_id: p_id, user_id: u_id, text: text, created_at: Time.now)
    redirect '/'
  end

  private

  def reply_params
    p_id, text = params.values
    u_id = current_user.id
    [p_id, text, u_id]
  end
end
