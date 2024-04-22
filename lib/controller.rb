require_relative 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: { gossips: Gossip.all }
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    author = params["gossip_author"]
    content = params["gossip_content"]
    gossip = Gossip.new(author, content)
    gossip.save
    redirect '/'
  end

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
end
