require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
      set :public_folder, 'public'
	  set :views, 'app/views'
	  enable :sessions
	  set :session_secret
    end

    get "/" do
      erb :index
    end

    get "/signup" do
		erb :signup
	end
	
	get "/users" do
		@users=User.all
		erb :'/user/index'
	end
  
    post "/users" do
		user = User.new(:username => params[:username],
		 :password => params[:password])

		if user.save
		  erb :success
		else
		  redirect "/failure"
		end
    end
  
    get "/login" do
		erb :login
    end

	post "/login" do
		user = User.find_by(:username => params[:username])
	   
		if user && user.authenticate(params[:password])
		  session[:id] = user.id
		  erb :success
		else
		  redirect "/failure"
        end
    end
  
	get "/success" do
		user = User.find_by(:username => params[:username])
		if logged_in?
			session[:id] = user.id
			erb :success
		else
			redirect "/login"
		end
	end

	post "/success" do
	  game = Game.new(:name => params[:name], :system => params[:system])
	   redirect "/success"
	end
	
	get "/games" do
		erb :games
	end

	get "/failure" do
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?
			!!session[:id]
		end

		def current_user
			User.find(session[:id])
		end
	end
end
