# frozen_string_literal: true

# Manages Peep object interactions with the DB.
# The table :peeps has the following columns:
# [:id, :user_id, :text, :created_at]
# PK = :id
# FK = :user_id
class Peep < Sequel::Model
  plugin :validation_helpers
  extend ERB::DefMethod
  PEEPS_DS = DB[:peeps]

  one_to_many :reply

  def_erb_method('erb()', 'app/views/partials/peep2.erb')

  def validate
    super
    validates_presence :text
    validates_presence :created_at,
                       message: 'is nil. Check your create/update method calls.'
  end

  def self.find(peep_id)
    warn '[DEPRECATION]: This method will be deprecated soon!'
    with_pk!(peep_id)
  end

  def self.all_per(user_id)
    Peep.where(user_id: user_id).reverse(:created_at).all
  end

  def self.all
    Peep.reverse(:created_at).all
  end

  def user
    User.find(user_id)
  end
end
