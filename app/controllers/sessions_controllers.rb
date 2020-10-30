class SessionsController < ApplicationController

    get '/login' do
        erb :'sessions/login'
    end

    post '/login' do
        @owner = Owner.find_by(username: params[:username])
        if @owner && @owner.authenticate(params[:password])
          session[:owner_id] = @owner.id
          erb :'owners/show'
        else
          erb :failure
        end
      end

    get '/logout' do
        session.clear
        redirect "/"
    end

end