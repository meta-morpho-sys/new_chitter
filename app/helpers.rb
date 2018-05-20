# frozen_string_literal: true

# View helper methods
module AppHelpers
  def invalid_user_session?
    request.path_info.split('/')[1] != 'login' && session[:user_id].nil?
  end

  # def valid_user_session?
  #   session[:user_id].nil?
  # end
  #
  # def logging_in?
  #   request.path_info.split('/')[1] == 'login'
  # end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
