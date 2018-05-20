# frozen_string_literal: true

# Controller for Peeps path
class Chitter < Sinatra::Base
  get '/user/:id/peeps' do
    erb :'peeps/index'
  end
end
