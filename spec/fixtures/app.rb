require 'sinatra'
require 'haml'

get '/list/:page' do |page|
  haml :list
end

get '/detail/:item_id' do |item_id|
  haml :detail
end


