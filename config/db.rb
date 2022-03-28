# frozen_string_literal: true

require 'pg'
require 'yaml'
class Db
  attr_accessor :con, :conf

  def initialize
    @conf = YAML.load_file('config/db.yml')
    # puts @conf.to_s
    # puts @conf['development'].to_s
    @conf = @conf['development']
    @con = PG.connect(user: @conf['username'],
                      password: @conf['password'],
                      dbname: @conf['database'],
                      host: @conf['host'],
                      port: @conf['port'])
  end

  def get_connection
    @con
  end
end
