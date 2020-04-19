class GameController < ApplicationController

    get '/games' do
      if logged_in? && current_user
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
        redirect '/games/show'
      else
        redirect '/users/new'
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
        @user = current_user
        @game = Game.find_by(id: params[:id])
        erb :'games/edit'
      else
        redirect '/failure'
      end
    end
  
    patch '/games/:id' do
      binding.pry
      if params[:name] != "" && params[:system] != ""
         @game = Game.find_by(params[:id])
         @game.name = params[:name]
         @game.system = params[:system]
         @game.user_id = current_user
         @game.save
         redirect to "/games/#{@game.id}"
      else
        redirect to "/games/#{@game.id}/edit"
      end
   end
  
    delete '/games/:id/edit' do
      @game = @user.games.find_by(id: params[:id])
      @user = current_user
      if logged_in?
        @game.delete
        redirect '/users/show'
      else
        redirect "/games/:id/edit"
      end
    end
  
end