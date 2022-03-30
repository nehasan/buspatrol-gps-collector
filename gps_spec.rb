# frozen_string_literal: true

require 'rspec'
require 'rack/test'
require_relative 'api/app'

RSpec.describe 'gps api', type: :request do
  include Rack::Test::Methods

  context 'Test api root endpoint' do
    let(:app)       { Api::App.new }
    let(:response)  { get '/' }
    it 'gets 200 response' do
      # get '/'
      expect(response.status).to eq 200
    end
  end

  context 'creating new point(s) api' do
    let(:app)       { Api::App.new }
    # let(:env)      { { "REQUEST_METHOD" => "POST", "REQUEST_PATH" => "/api/gps/create" } }
    # let(:response) { app.call(env) }
    # let(:body)     { response[2][0] }
    let(:headers)   { { 'CONTENT_TYPE' => 'application/json' } }
    # let(:params)    { '{ "geometries": [{ "type": "Point", "coordinates": [24.976567, 60.1612500] } ] }' }
    let(:params)    { { 'geometries' => [{ 'type' => 'Point', 'coordinates' => [24.976567, 60.1612500] }] } }

    # let(:response) { post '/api/gps/create', JSON.parse(params), headers }
    # let(:response) { post '/api/gps/create', params.to_json, headers }

    it 'creates a point' do
      post '/api/gps/create', params.to_json, headers
      puts params.to_json
      puts headers
      # puts response

      expect(last_response.content_type).to eq('application/json')
      expect(last_response.status).to eq 200
    end
  end
end
