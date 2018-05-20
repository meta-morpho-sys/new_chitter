# frozen_string_literal: true

# View helper methods
module Helpers
  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
