require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

get '/detail/:item_id' do |item_id|
  haml :detail
end


