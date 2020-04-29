class GameController < ApplicationController

    get '/games' do
      if logged_in?
        @user = current_user
        @game = current_user.games.find_by(id: params[:id])
        erb :'games/game_list'
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
        redirect "/users/#{current_user.slug}"
      else
        redirect '/games/new'
      end
    end
  
    get '/games/:id' do
      if current_user
        @game = current_user.games.find_by(id: params[:id])
        erb :users/show
      else
        redirect '/failure'
      end
    end
  
    get '/games/:id/edit' do
      if !logged_in?
        redirect '/login'
      end
        #@user = current_user
        @game = current_user.games.find_by(id: params[:id])
        if @game == nil
          redirect "/users/#{current_user.slug}"
        end
        erb :'games/edit'
      
    end
  
    patch '/games/:id' do
      if !logged_in?
        redirect '/login'
      end
        #@user = current_user
        @game.update(name: params[:name], system: params[:system])
        if @game == nil
          redirect "/users/#{current_user.slug}"
        end
        erb :'games/edit'      
      #if current_user
      #  @game = Game.find_by(id: params[:id])
      #   @game.update(name: params[:name], system: params[:system])
      #   redirect to ("/users/#{current_user.slug}")
      #else
      #  redirect to "failure"
      #end
   end
  
    delete '/games/:id' do
      if !logged_in?
        redirect '/login'
      end
      if current_user
        @game = current_user.games.find_by(id: params[:id])
        @game.delete
        redirect to "/users/#{current_user.slug}"
      end
    end
  
end