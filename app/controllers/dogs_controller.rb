class DogsController < ApplicationController

    get '/dogs' do
        if logged_in?
            @dogs = current_user.dogs
            erb :'/dogs/show'
        else
            erb :'fail2'
        end
    end

    get '/dogs/new' do
        if logged_in?
            erb :'dogs/new'
        else
            erb :'fail2'
        end
    end

    post '/dogs' do
        @dog = current_user.dogs.build(params)
        if @dog.save
            redirect to "/dogs/#{@dog.id}"
        end
    end

    get '/dogs/:id' do
        if logged_in?
            @dog = Dog.find_by(params[:id])
            erb :'/dogs/show'
        else
            erb :'fail2'
        end
    end

end