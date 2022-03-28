# frozen_string_literal: true

require 'json'
require_relative 'gps'
module Api
  class App
    def call(env)
      # puts "--- #{env['REQUEST_METHOD']} | #{env['REQUEST_PATH']}"
      case env['REQUEST_PATH']
      when '/'
        [
          200,
          { 'Content-Type' => 'text/plain' },
          ['GPS COLLECTOR']
        ]
      when '/favicon.ico'
        [
          200,
          { 'Content-Type' => 'text/plain' },
          ['']
        ]
      when '/api/gps/create'
        params = env['rack.input'].read
        params = JSON.parse(params)
        # puts params
        Api::Gps.new.create(params)
        [
          200,
          { 'Content-Type' => 'application/json' },
          [{ success: true }.to_json]
        ]
      when '/api/gps/in-radius'
        # puts "#{env['REQUEST_METHOD']}"
        params = env['rack.input'].read
        params = JSON.parse(params)
        # puts params.to_s
        data = Api::Gps.new.in_radius(params)
        [
          200,
          { 'Content-Type' => 'application/json' },
          [data.to_json]
        ]
      when '/api/gps/in-polygon'
        params = env['rack.input'].read
        params = JSON.parse(params)
        data = Api::Gps.new.in_polygon(params)
        [
          200,
          { 'Content-Type' => 'application/json' },
          [data.to_json]
        ]
      end
    end

    private
  end
end
