class UsersController < ApplicationController
    
    get '/signup' do
        if logged_in?
          redirect to "/users/#{current_user.id}"
        else
          erb :'/users/create_user'
        end
    end
    
    get '/login' do
        erb :'/users/login_user'
    end
    #get '/login' do
        #if logged_in?
         # redirect to "/users/#{current_user.id}"
        #else
         # erb :'/users/login_user'
        #end
    #end
    
    post '/login' do
        @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to "users/#{@user.id}"
        else
            erb :failure
        end
    end

    post '/signup' do
        @user = User.new(name: params[:name], username: params[:username], password: params[:password])
        if @user.save
          session[:user_id] = @user.id
          redirect to "/users/#{@user.id}"
        else
          redirect to '/signup'
        end
    end

    get "/failure" do
        erb :failure
      end

    get '/users/:id' do
        @user = User.find_by_id(params[:id])
        if logged_in? && @user == current_user
          erb :'/users/show_user'
        else
          redirect to '/login'
        end
      end

      get "/logout" do
        session.clear
        redirect "/"
      end

end
