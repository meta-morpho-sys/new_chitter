# frozen_string_literal: true

require 'sinatra'
require 'sinatra/flash'
require_relative './db/sequel_setup'

require_relative 'lib/flash_msgs'
require_relative 'lib/str_msgs'
require_relative 'helpers'
require_relative 'models/user'
require_relative 'models/peep'
require_relative 'models/reply'

require_relative './server'
require_relative 'controllers/login'
require_relative 'controllers/users'
require_relative 'controllers/peeps_per_user'
