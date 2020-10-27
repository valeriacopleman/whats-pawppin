class UsersController < ApplicationController
    
    get '/signup' do
        if logged_in?
          redirect to "/users/#{current_user.id}"
        else
          erb :'/users/create_user'
        end
    end
    
    get '/login' do
        if logged_in?
          redirect to "/users/#{current_user.id}"
        else
          erb :'/users/login_user'
        end
      end
    

end
