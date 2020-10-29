class DogsController < ApplicationController

    get '/dogs' do
        #binding.pry
        @dogs = current_user.dogs
        erb :'dogs/index'
      end
  
      get '/dogs/new' do
        erb :'dogs/new'
      end
  
      post '/dogs' do
        dog = current_user.dogs.build(params)
        if dog.save
          redirect "/dogs/#{dog.id}"
        else
          redirect '/dogs/new'
        end
      end

      get '/dogs/:id' do
        #binding.pry
        @dog = Dog.find_by(id: params[:id])
        if @dog
          erb :'dogs/show'
        else
          redirect '/dogs'
        end
      end
  
      get '/dogs/:id/edit' do
        @owner = Owner.all 
        @dog = Dog.find_by(params)
        erb :'dogs/edit'
      end
  
      patch '/dogs/:id' do 
        dog = Dog.find_by(id: params[:id])
        if dog.update(name: params[:name], age: params[:age], breed: params[:breed])
          redirect "/dogs/#{dog.id}"
        else 
          redirect "dogs/#{dog.id}/edit"
        end
      end
  
      delete '/dogs/:id' do
        @dog = Dog.find_by(id: params[:id])
        @dog.destroy
        redirect '/dogs'
      end

end