class ParksController < ApplicationController

  get '/parks' do
    @parks = current_user.parks
    erb :'parks/index'
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
        @park = current_user.dogs.find_by(id: params[:id])
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
        @park = current_user.dogs.find_by(id: params[:id])
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

end