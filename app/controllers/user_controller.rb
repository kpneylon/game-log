class UserController < ApplicationController

    get '/signup' do
      if !logged_in? 
        erb :'/users/new_user'
      else
        redirect "/users/#{current_user.slug}" 
      end
    end
  
    post '/signup' do
      if params[:username] != "" && params[:password] != ""
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
        if @user.valid?
          redirect "/users/#{@user.slug}"
        else
          erb :'/failure'
        end
      else
        erb :'/failure'
      end
    end
  
    get '/login' do
      if !logged_in?
      erb :'/users/login'
      else
        redirect "/users/#{current_user.slug}"
      end
    end
  
    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect "/users/#{@user.slug}"
        else
          redirect '/failure'
        end
    end
  
    get '/users/:slug' do
      if !logged_in?
        redirect '/login'
      else
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
      end
    end
  
    get '/logout' do
      session.clear
      redirect '/'
    end
  
  end