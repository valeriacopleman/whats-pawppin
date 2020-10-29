class ParksController < ApplicationController

  get '/parks' do
    @parks = Park.all
    erb :'parks/index'
  end
 
    get '/parks/new' do
      erb :'parks/new'
    end

    post '/parks' do
      park = current_user.parks.build(params)
      if park.save
        redirect "/parks/#{park.id}"
      else
        redirect '/parks/new'
      end
    end

    get '/parks/:id' do
      @park = Park.find_by(id: params[:id])
      if @park
        erb :'parks/show'
      else
        redirect '/parks'
      end
    end

    get '/parks/:id/edit' do
      @owner = Owner.all 
      @park = Park.find_by(id: params[:id])
      erb :'parks/edit'
    end

    patch '/parks/:id' do 
      park = Park.find_by(id: params[:id])
      if park.update(name: params[:name], location: params[:location], description: params[:description])
        redirect "/parks/#{park.id}"
      else 
        redirect "/parks/#{park.id}/edit"
      end
    end

    delete '/parks/:id' do
      @park = Park.find_by(id: params[:id])
      @park.destroy
        redirect "/parks"
    end

    #get "/dogparks" do
     #   if logged_in?
      #      @dogparks = current_user.dogparks
       #     erb :'/dogparks/parks'
        #else
         #   erb :'fail2'
        #end
    #end
    #post '/parks' do
     #   @user = User.find_by(username: params[:username])
    #if @user && @user.authenticate(params[:password])
        #  session[:user_id] = @user.id
        #  erb :'index'
          #redirect to "dogparks/parks"
          #redirect to "users/#{@user.id}"
        #else
           # erb :failure
        #end
    #end
    #get '/parks' do
        #@user = User.find_by_id(params[:id])
        #if logged_in? && @user == current_user
          #  erb :'/dogparks/parks'
          #erb :'/users/show_user'
        #else
          #redirect to '/login'
        #end
      #end

end