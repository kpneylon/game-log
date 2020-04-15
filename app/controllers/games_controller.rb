class GameController < ApplicationController

    get '/games' do
      if logged_in? && current_user
        @user = current_user
        session[:user_id] = @user.id
        @games = Game.all
        erb :'/games/home'
      else
        redirect '/'
      end
    end
  
    get '/games/new' do
      if logged_in? && current_user
        erb :'/games/new_game'
      else
        erb :'failure'
      end
    end
  
    post '/games' do
      @user = current_user
      if logged_in? && !params[:name].empty?
      @game = Games.create(name: params[:name], system: params[:system])
      @user.games << @game
      redirect '/games'
      else
        redirect '/games/new_game'
      end
    end
  
    get '/games/:id' do
      if logged_in?
        @game = Games.find_by(id: params[:id])
        erb :'games/show'
      else
        redirect '/failure'
      end
    end
  
    get '/games/:id/edit' do
      if logged_in?
        @game = Games.find_by(id: params[:id])
        erb :'games/edit'
      else
        redirect '/failure'
      end
    end
  
    patch '/games/:id' do
      if logged_in? && !params[:name].empty?
        @game = Games.find_by(id: params[:id])
        @game.name = (params[:name])
        @game.save
        redirect "/games/#{@game.id}"
      else
        redirect "/games/#{params[:id]}/edit"
      end
    end
  
    delete '/games/:id/edit' do
      @game = Games.find_by(id: params[:id])
      @user = current_user
      if logged_in?
        @game.delete
        redirect '/games'
      else
        redirect "/games/#{@game.id}"
      end
    end
  
  end