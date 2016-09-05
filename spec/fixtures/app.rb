require 'sinatra'
require 'haml'

get '/list/:page' do |page|
  if page.to_i < 2
    @next_page = (page.to_i + 1).to_s
    haml :list
  else
    haml :list_last
  end
end

get '/detail/:item_id' do |item_id|
  haml :detail
end


