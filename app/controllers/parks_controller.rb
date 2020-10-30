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

end