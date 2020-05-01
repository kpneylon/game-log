class GameController < ApplicationController

    get '/games' do
      if logged_in?
        @user = current_user
        @games = Game.all
        erb :'games/game_list'
      end
    end
  
    get '/games/new' do
      redirect_if_not_logged_in
        erb :'/games/new_game'
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
  
    get '/games/:id/edit' do
      redirect_if_not_logged_in
        @game = current_user.games.find_by(id: params[:id])
        if @game == nil
          redirect "/users/#{current_user.slug}"
        end
        erb :'games/edit'
      
    end
  
    patch '/games/:id' do
      redirect_if_not_logged_in
      @game = current_user.games.find_by(id: params[:id])
      if @game == nil
        redirect "/users/#{current_user.slug}"
      end
      @game.update(name: params[:name], system: params[:system])
       
        erb :'games/edit'      
   end
  
    delete '/games/:id' do
      redirect_if_not_logged_in
      @game = current_user.games.find_by(id: params[:id])
      if @game == nil
        redirect "/users/#{current_user.slug}"
      end
      @game.delete
      redirect to "/users/#{current_user.slug}"
    end
  
end