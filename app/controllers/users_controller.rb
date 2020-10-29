class UsersController < ApplicationController
    
    get '/signup' do
        if logged_in?
            erb :'index'
            #redirect to "dogparks/parks"
          #redirect to "/users/#{current_user.id}"
        else
          erb :'/users/create_user'
        end
    end
    
    get '/login' do
        erb :'/users/login_user'
    end

    post '/profile' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        erb :'index'
        #redirect to "dogparks/parks"
        #redirect to "users/#{@user.id}"
      else
          erb :failure
      end
  end

    post '/signup' do
        if params[:name] == "" || params[:username] == "" || params[:password] == ""
            redirect '/failure'
          else
            @user = User.new(name: params[:name], username: params[:username], password: params[:password])
            if @user.save
                session[:user_id] = @user.id
                erb :'index'
                #redirect to "dogparks/parks"
                #redirect to "/users/#{@user.id}"
            end
          end
        #@user = User.new(name: params[:name], username: params[:username], password: params[:password])
        #if @user.save
         # session[:user_id] = @user.id
         # redirect to "/users/#{@user.id}"
        #else
          #redirect to '/signup'
        #end
    end

    get "/failure" do
        erb :failure
      end

    #get '/parks' do
       # @user = User.find_by_id(params[:id])
        #if logged_in? && @user == current_user
           # erb :'/dogparks/parks'
          #erb :'/users/show_user'
        #else
          #redirect to '/login'
        #end
      #end

      get '/profile/:id' do
        @user = User.find_by(id: params[:id])
        erb :'index'
      end

      get '/profile/:id/edit' do
        @user = User.find_by(id: params[:id])
        if logged_in? && @user == current_user
          erb :'/users/edit_user'
        else
          redirect to '/users/:id'
        end
      end

      patch '/profile/:id' do
        @user = User.find_by(id: params[:id])
        @user.username = params[:username]
        @user.password = params[:password]
        if logged_in? && @user == current_user && @user.valid?
          @user.save
          erb :'index'
          #redirect to "/users/#{@user.id}"
        else
          redirect to '/login'
        end
      end

      get "/logout" do
        session.clear
        redirect "/"
      end

end
