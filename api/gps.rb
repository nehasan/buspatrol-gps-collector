# frozen_string_literal: true

require_relative '../config/db'
module Api
  class Gps
    # POST api/gps/create
    def create(params)
      # puts params['geometries']
      points = params['geometries']
      con = Db.new.get_connection
      points.each do |point|
        puts point['coordinates']
        sql = <<~SQL
          INSERT into public.geoms(name, geom)
          VALUES ('point', 'POINT(#{point['coordinates'][0]} #{point['coordinates'][1]})')
        SQL
        puts sql.to_s
        con.exec(sql)
      end
      con.close
    end

    # GET api/gps/in-radius
    def in_radius(params)
      con = Db.new.get_connection
      point = params['geometry'].nil? ? nil : params['geometry']['coordinates']
      radius = params['radius'].nil? ? nil : params['radius']
      if point && radius
        sql = <<~SQL
          SELECT gid, ST_AsGeoJSON(geom) as geometry
          FROM public.geoms
          WHERE ST_DWithin(geom, 'POINT(#{point[0]} #{point[1]})', #{radius})
        SQL
      end
      puts sql.to_s
      results = con.exec(sql)
      results.each do |r|
        puts r.to_s
      end
      con.close
      # { points: results.collect { |x| x } }
      # byebug
      results.nil? ? {} : results.collect { |x| { gid: x['gid'], geometry: JSON.parse(x['geometry']) } }
    end

    # GET '/api/gps/in-polygon'
    def in_polygon(params)
      con = Db.new.get_connection
      polygon_points = params['geometry'].nil? ? nil : params['geometry']['coordinates'][0]
      puts polygon_points.to_s

      points = ''
      polygon_points.each { |x| points += "#{x.join(' ')}," } # [[1,3],[3,4],[4,5]] turns into '1 3, 3 4, 4 5,'
      points = points[0..(points.length - 2)]
      if points != ''
        sql = <<~SQL
          SELECT gid, ST_AsGeoJSON(geom) as geometry
          FROM public.geoms
          WHERE ST_Contains('POLYGON((#{points}))', geom)
        SQL
      end
      puts sql.to_s
      results = con.exec(sql)

      results.each do |r|
        puts r.to_s
      end
      con.close
      results.nil? ? {} : results.collect { |x| { gid: x['gid'], geometry: JSON.parse(x['geometry']) } }
    end
  end
end


# page 60 ST_DWithin : post-gis doc
# ST_Contains('POLYGON((a1 a2, b1 b2 ...))')
