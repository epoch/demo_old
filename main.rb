# dependencies
require 'sinatra' # libraries & gems


if settings.development?
  require 'sinatra/reloader' # depends on a gem sinatra-contrib
  require 'pry'
end

require 'pg'
require_relative 'models/dish'

get '/' do
  @dishes = all_dishes()
  erb :index
end

get '/donate' do
  erb :donate
end

get '/details' do
  @dish = find_one_dish(params[:id])
  erb :details
end

get '/new_dish' do
  erb :new
end

post '/create_dish' do
  create_dish(params[:name], params[:image_url])
  # redirect "/"
end

delete '/destroy_dish' do
  destroy_dish(params[:id])
  redirect "/"
end

get '/edit' do
  # building the edit form
  @dish = find_one_dish(params[:id])
  erb :edit
end

patch '/update_dish' do
  # connect to db
  conn = PG.connect(dbname: "goodfoodhunting")
  # prepare the sql - new name, new image_url
  sql =  "update dishes set name = '#{ params[:name] }', "
  sql += "image_url = '#{ params[:image_url] }' "
  sql += "where id = #{ params[:id] };"
  # exec sql
  conn.exec(sql)
  # close connection to db
  conn.close
  # redirect to a route of dt choice - the details page
  redirect "/details?id=#{ params[:id] }"
end



