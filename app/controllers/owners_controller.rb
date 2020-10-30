class OwnersController < ApplicationController
  
  get '/signup' do
    if logged_in?
      erb :'owners/show'
    else
      erb :'owners/signup'
    end
  end

#signup
  post '/signup' do
    @owner = Owner.new(name: params[:name], username: params[:username], password: params[:password])
    if @owner.save
      session[:owner_id] = @owner.id
      erb :'owners/show'
    else
      redirect '/failure'
    end
  end

  get '/owners' do
    @owner = current_user
    if logged_in?
      redirect "/owners/#{@owner.id}" 
    else
      erb :fail2
    end
  end

    get "/failure" do
        erb :failure
      end

      get '/owners/:id' do
        @owner = Owner.find_by(id: params[:id])
        if logged_in? && @owner == current_user
          erb :'owners/show'
        else
          erb :fail2
        end
      end
      

      get '/owners/:id/edit' do
        @owner = Owner.find_by(id: params[:id])
        if logged_in? && @owner == current_user
          erb :'/owners/edit'
        else
          redirect "/owners/#{@owner.id}"
        end
      end

      patch '/owners/:id' do 
        owner = Owner.find_by(id: params[:id])
        if owner.update(name: params[:name], username: params[:username], password: params[:password])
          redirect "/owners/#{owner.id}"
        else 
          redirect "/owners/#{owner.id}/edit"
        end
      end

      delete '/owners/:id' do
        @owner = Owner.find_by_id(params[:id])
        if logged_in? && @owner == current_owner
          @owner.dogs.each do |d|
            d.delete
          end
          @owners.parks.each do |p|
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
