require 'sinatra'
require 'sinatra/reloader' if development?
require 'mongoid'

project_root = File.dirname(__FILE__)
Mongoid.load!(File.join(project_root, 'mongoid.yml'))

class Weather
  include Mongoid::Document

  field :list, type: Hash
end

get '/hello' do
  'Hello Sinatra!!!!'
end

# Create a new list weather
post '/list' do
  weather = Weather.create!(params[:list])
  weather.to_json
end

# Read all list weather
get '/list' do
  Weather.to_json
end

# read an individual weather in period
get '/weather/:key' do
  Weather.to_json[params[:key]]
end

# Update an existing list weather
patch '/list' do
  weather = Weather.first.update(params[:list])
  weather.to_json
end

# Delete the list weather
delete '/list' do
  weather = Weather.all.delete
  weather.to_json
end