class ParksController < ApplicationController

  get '/parks' do
    if logged_in?
      @parks = current_user.parks
      erb :'parks/index'
    else
      erb :fail2
    end
  end
 
  get '/parks/new' do
    if logged_in?
      erb :'parks/new'
    else
      erb :fail2
    end
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
    if logged_in?
      @park = current_user.parks.find_by(id: params[:id])
      if @park
        erb :'parks/show'
      else
        redirect '/parks'
      end
    else
      erb :fail2
    end
  end

  get '/parks/:id/edit' do
    if logged_in?
      @park = current_user.parks.find_by(id: params[:id])
      if @park
        erb :'parks/edit'
      else
        redirect '/parks'
      end
    else 
      erb :fail2
    end
  end

  patch '/parks/:id' do 
    park = current_user.parks. find_by(id: params[:id])
    if park.update(name: params[:name], location: params[:location], description: params[:description])
      redirect "/parks/#{park.id}"
    else 
      redirect "/parks/#{park.id}/edit"
    end
  end

  delete '/parks/:id' do
    if logged_in?
      @park = current_user.parks.find_by(id: params[:id])
      if @park
        @park.destroy
      end
        redirect "/parks"  
    else
      erb :fail2
    end
  end

end