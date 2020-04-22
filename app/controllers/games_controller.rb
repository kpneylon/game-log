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
        redirect "/users/#{current_user.slug}"
      else
        redirect '/users/new'
      end
    end
  
    get '/games/:id' do
      if current_user
        @game = current_user.games.find_by(params[:id])
        erb :users/show
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
      if current_user
         @game = Game.find_by(id: params[:id])
         @game.update(name: params[:name], system: params[:system], user_id: current_user.id)
         redirect to ("/users/#{current_user.slug}")
      else
        redirect to "failure"
      end
   end
  
    delete '/games/:id' do
      if current_user
        @game = Game.find_by(id: params[:id])
        @game.delete
        redirect to "/users/#{current_user.slug}"
      end
    end
  
end