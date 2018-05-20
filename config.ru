# frozen_string_literal: true

Bundler.require(:default)

require_relative './app/app'

use Rack::MethodOverride

run Chitter
