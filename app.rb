require "sinatra"
require "./lib/database"
require "./lib/contact_database"
require "./lib/user_database"
require "rack-flash"

class ContactsApp < Sinatra::Base
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @contact_database = ContactDatabase.new
    @user_database = UserDatabase.new

    jeff = @user_database.insert(username: "Jeff", password: "jeff123")
    hunter = @user_database.insert(username: "Hunter", password: "puglyfe")

    @contact_database.insert(:name => "Spencer", :email => "spen@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Jeff D.", :email => "jd@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Mike", :email => "mike@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Kirsten", :email => "kirsten@example.com", user_id: hunter[:id])
  end

  get "/" do
    erb :home
  end

  get "/log_in" do
    erb :log_in
  end

  post "/logging_in" do
    hash = {username: params[:username], password: params[:password]}
    user_info = @user_database.all.detect { |user_hash| user_hash[:username] == hash[:username] && user_hash[:password] == hash[:password]}
    session[:user_id] = user_info[:id]
    flash[:notice] = "Welcome, #{user_info[:username]}"
    redirect "/"
  end

  # get "/contact_list" do
  #   contact_list = "<ul>"
  #   @contact_database.each do |hash|
  #     if hash[:user_id] == session[:user_id]
  #       contact_list << hash[:]
  #     end
  #   end
  # end

  get "/log_out" do
    session.delete(:user_id)
    redirect "/"
  end

end
