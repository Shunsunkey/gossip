require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'controller'
require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: { gossips: Gossip.all }
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end
<<<<<<< HEAD
  
  get '/gossips/:id' do
    id = params['id'].to_i
    @gossip = Gossip.find(id)
    erb :show
  end
  
  get '/gossips/:id/edit/' do
    id = params['id'].to_i
    @gossip = Gossip.find(id)
    erb :edit
  end
  
  post '/gossips/:id/edit/' do
    id = params['id'].to_i
    gossip = Gossip.find(id)
    gossip.update(params['gossip_author'], params['gossip_content'])
    redirect '/'
  end  
  
=======

  get '/gossips/:id/' do
    @gossip = Gossip.find(params['id'].to_i)
    erb :show
  end
  get '/gossips/:id/edit' do
    @gossip = Gossip.find(params['id'].to_i)
    erb :edit
  end
  post '/gossips/:id/edit' do
    @gossip = Gossip.find(params['id'].to_i)
    @gossip.author = params['author']
    @gossip.content = params['content']
    @gossip.save
    redirect "/gossips/#{params['id']}"
  end
>>>>>>> acef093249f7bee6d23631a7632be78c7410215a
end
