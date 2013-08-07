require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if File.exists?('c:/')

require 'haml'

require './helpers'

enable :sessions

before do
  init_config

  @is_logged = session[:is_logged]
  if !@is_logged && request.path_info != '/login'
    redirect '/login'
  end
end

get '/' do
  haml :index
end

get '/login' do
  haml :login
end

get '/logout' do
  session[:is_logged] = nil
  redirect '/'
end 

post '/login' do
  if @password == params[:pwd]
    session[:is_logged] = true
    redirect '/try' if @urls.size == 0
    redirect '/'
  else
    redirect '/login?msg=errorlogin'
  end
end

get '/reload_config' do
  reload_config
  redirect '/'
end


get '/page/:name' do
  static_pages = {
    'about'   => 'README.md',
    'contact' => 'docs/CONTACT.md'
  }
  if static_pages.keys.include?(params[:name])
    @content = File.read(static_pages[params[:name]])
    haml :page
  end
end


get '/update/:pos' do
  @pos      = params[:pos]
  @url_item = @urls[@pos.to_i]
  haml :update
end

post '/update' do
  url_item = @urls[params[:pos].to_i]

  source_url  = url_item['url']
  blog_domain = @config['blog']
  wp_post_id  = url_item['wp_id']
  wp_login    = params[:login]
  wp_pwd      = params[:password]

  publish_from_source_to_wordpress(source_url, blog_domain, wp_post_id, wp_login, wp_pwd)

  redirect '/'
end

get '/try' do
  @content = File.read('docs/TRY.md')
  @default_url = 'https://raw.github.com/nemilya/github2wp/master/docs/DEMO.md'
  haml :try
end

post '/try' do
  source_url  = params[:url]
  blog_domain = params[:blog]
  wp_post_id  = params[:wp_id]
  wp_login    = params[:login]
  wp_pwd      = params[:password]

  publish_from_source_to_wordpress(source_url, blog_domain, wp_post_id, wp_login, wp_pwd)

  redirect '/try'
end