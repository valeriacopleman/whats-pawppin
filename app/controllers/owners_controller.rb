class OwnersController < ApplicationController
  
  get '/signup' do
    if logged_in?
      erb :'owners/index'
    else
      erb :'owners/signup'
    end
  end

  post '/signup' do
    @owner = Owner.new(name: params[:name], username: params[:username], password: params[:password])
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
      #redirect "/whatspawppin/#{@owner.id}" 
      erb :'owners/index'
    else
      erb :fail2
    end
  end

  #get '/owners' do
   # @owner = current_user
   # if logged_in?
   #   redirect "/owners/#{@owner.id}" 
   # else
    #  erb :fail2
   # end
  #end

    get "/failure" do
        erb :failure
      end

      #get '/owners/:id' do
      #  @owner = Owner.find_by(id: params[:id])
       # if logged_in? && @owner == current_user
       #   erb :'owners/show'
      #  else
       #   erb :fail2
       # end
      #end

      #patch '/owners/:id' do 
       # owner = Owner.find_by(id: params[:id])
       # if owner.update(name: params[:name], username: params[:username], password: params[:password])
        #  redirect "/owners/#{owner.id}"
       # else 
        #  redirect "/owners/#{owner.id}/edit"
       # end
     # end

end
