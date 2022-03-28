# frozen_string_literal: true

require_relative 'db'
class Migrations
  def initialize
  end

  def create_table_geoms
    con = Db.new.get_connection
    sql = <<SQL
CREATE table IF NOT EXISTS public.geoms(
  gid SERIAL PRIMARY KEY,
  name VARCHAR(64),
  geom geometry(POINT)
)
SQL
    result = con.exec(sql)
    con.close
    puts result.to_s
  end
end