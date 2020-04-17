class GameController < ApplicationController

    get '/games' do
      if logged_in? && current_user
        @user = current_user
        session[:user_id] = @user.id
        @game = Game.all
        erb :'/games/edit'
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
      if params[:name] != "" && params[:system] != ""
        @game = Game.create(name: params[:name], system: params[:system])
        current_user.games << @game
        redirect '/games/new'
      else
        redirect '/users/show'
      end
    end
  
    get '/games/:id' do
      if logged_in?
        @game = Game.find_by(id: params[:id])
        erb :'users/show'
      else
        redirect '/failure'
      end
    end
  
    get '/games/:id/edit' do
      if logged_in?
        @game = Game.find_by(id: params[:id])
        erb :'games/edit'
      else
        redirect '/failure'
      end
    end
  
    patch '/games/:id' do
      if logged_in? && !params[:name].empty?
        @game = Game.find_by(name: params[:name], system: params[:system])
        @game.name = (params[:name])
        @game.system = (params[:system])
        @game.save
        redirect "/games/#{@game.id}"
      else
        redirect "/games/#{params[:id]}/edit"
      end
    end
  
    delete '/games/:id/edit' do
      @game = Game.find_by(id: params[:id])
      @user = current_user
      if logged_in?
        @game.delete
        redirect '/users/show'
      else
        redirect "/games/#{@game.id}"
      end
    end
  
end