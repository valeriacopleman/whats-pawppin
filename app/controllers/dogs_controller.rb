class DogsController < ApplicationController

    get '/dogs' do
        if logged_in?
            @dogs = current_user.dogs
            erb :'dogs/index'
        else
            erb :fail2
        end
    end
  
    get '/dogs/new' do
        if logged_in?
            erb :'dogs/new'
        else
            erg :fail2
        end
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
        if logged_in?
            @dog = current_user.dogs.find_by(id: params[:id])
            if @dog
                erb :'dogs/show'
            else
                redirect '/dogs'
            end
        else
            erb :fail2
        end
    end
  
    get '/dogs/:id/edit' do
        if logged_in?
            @dog = current_user.dogs.find_by(params)
            erb :'dogs/edit'
            if @dog 

            end

    end
  
      patch '/dogs/:id' do 
        dog = current_user.dogs.find_by(id: params[:id])
        if dog.update(name: params[:name], age: params[:age], breed: params[:breed])
          redirect "/dogs/#{dog.id}"
        else 
          redirect "dogs/#{dog.id}/edit"
        end
      end
  
      delete '/dogs/:id' do
        @dog = current_user.dogs.find_by(id: params[:id])
        @dog.destroy
        redirect '/dogs'
      end

end