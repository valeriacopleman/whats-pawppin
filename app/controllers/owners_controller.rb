class OwnersController < ApplicationController
  
  get '/owners/new' do
    if logged_in?
      erb :index
    else
      erb :'/owners/create_owner'
    end
  end
    
  get '/login' do
      erb :'/owners/login_owner'
  end

  post '/owners' do
    @owner = Owner.find_by(username: params[:username])
    if @owner && @owner.authenticate(params[:password])
      session[:owner_id] = @owner.id
      erb :index
    else
      erb :failure
    end
  end

  post '/owners/new' do
    if params[:name] == "" || params[:username] == "" || params[:password] == ""
      redirect '/failure'
    else
      @owner = Owner.new(name: params[:name], username: params[:username], password: params[:password])
      if @owner.save
        session[:owner_id] = @owner.id
        erb :index
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

      

      get '/owners/:id/edit' do
        @owner = Owner.find_by(id: params[:id])
        if logged_in? && @owner == current_user
          erb :'/owners/edit_owner'
        else
          redirect "/owners/#{@owner.id}"
        end
      end

      patch '/owners/:id' do
        @owner = Owner.find_by(id: params[:id])
        # logged_in? && @owner == current_user && @owner.valid?
        if @owner.update(name: params[:name], username: params[:username])
          #@owner.save
          #erb :index
          redirect to "/owners/#{@owner.id}"
        else
          redirect "owners/#{@owner.id}/edit"
        end
      end

      get '/owners/:id' do
        @owner = Owner.find_by(id: params[:id])
        if logged_in? && @owner == current_user
          erb :index
        else
          erb :fail2
        end
      end

      get "/logout" do
        session.clear
        redirect "/"
      end

      delete '/owners/:id' do
        @owner = Owner.find_by_id(params[:id])
        if logged_in? && @owner == current_user
          @owner.dogs.each do |d|
            d.delete
          end
          @owners.dogparks.each do |p|
            p.delete
          end
          @owner.delete
          session.clear
          redirect to '/'
        else
          redirect to '/login'
        end
     end

end
