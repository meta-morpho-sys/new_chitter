# frozen_string_literal: true

# View helper methods
module Helpers
  def valid_user_session?
    request.path_info.split('/')[1] != 'login' && session[:user_id].nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
