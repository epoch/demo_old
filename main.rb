# dependencies
require 'sinatra' # microframework for making web apps
require 'pg' # library for intefacing with the postgresql database

if settings.development?
  # development dependencies
  require 'sinatra/reloader' # only reloads the main.rb file by default
  also_reload 'models/*' 
  require 'pry'
end

def run_sql(sql)
  conn = PG.connect(ENV['DATABASE_URL'] || { dbname: "goodfoodhunting" })
  records = conn.exec(sql)
  conn.close
  return records
end

require_relative 'models/dish'
require_relative 'models/user'

# server gives out long passphrase to every client 
# clients return with long passphrase for server to remember who they are
enable :sessions 

get '/' do
  @dishes = all_dishes
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
  redirect "/"
end

delete '/destroy_dish' do
  destroy_dish(params[:id])
  redirect "/"
end

get '/edit' do
  @dish = find_one_dish(params[:id])
  erb :edit
end

patch '/update_dish' do
  update_dish(params[:id], params[:name], params[:image_url])
  redirect "/details?id=#{ params[:id] }"
end

get '/users' do
  @users = all_users()
  erb :all_users
end

get '/user_details' do
  @user = find_one_user(params[:id])
  erb :show_user
end

get '/login' do
  erb :login
end

post '/login' do
  # check record exist in the db
  user = find_user_by_email(params[:email])
  # check password is valid for that record
  if BCrypt::Password.new( user["password_digest"] ) == params[:password]
    # write down id of login user (we usually say create a session for the user)
    session[:user_id] = user["id"]
    # redirect to secret location, just home page for now
    redirect "/" # its up to you prob user dashboard or profile page
  else
    return "no frynuts"
  end
end



