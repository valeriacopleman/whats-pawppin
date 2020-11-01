class OwnersController < ApplicationController
  
  get '/signup' do
    if logged_in?
      erb :'owners/index'
    else
      erb :'owners/signup'
    end
  end

  post '/signup' do
    @owner = Owner.new(params)
    if @owner.save
      session[:owner_id] = @owner.id
      redirect "/whatspawppin"
    else
      redirect '/failure'
    end
  end

  get '/whatspawppin' do
    @owner = current_user
    if logged_in? && @owner == current_user 
      erb :'owners/index'
    else
      erb :fail2
    end
  end

  get "/failure" do
    erb :failure
  end

end
