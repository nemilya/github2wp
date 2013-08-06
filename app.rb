require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if File.exists?('c:/')

require 'haml'

require './helpers'

enable :sessions

before do
  require 'yaml'
  @config   = YAML.load(open('config.yml'))
  @blog_url = 'http://' + @config['blog']
  @urls     = @config['urls']
  @is_logged = session[:is_logged]
  if !@is_logged && request.path_info != '/login'
    redirect '/login'
  end
end

get '/login' do
  haml :login
end

post '/login' do
  if @config['pass-word'] == params[:pwd]
    session[:is_logged] = true
    redirect '/'
  else
    redirect '/login?msg=errorlogin'
  end
end

get '/logout' do
  session[:is_logged] = nil
  redirect '/'
end 

get '/' do
  haml :index
end

get '/about' do
  @content = File.read('README.md')
  haml :page
end

get '/contact' do
  @content = File.read('CONTACT.md')
  haml :page
end

get '/update/:pos' do
  @pos      = params[:pos]
  @url_item = @urls[@pos.to_i]
  haml :update
end

post '/update' do
  url_item = @urls[params[:pos].to_i]
  cnt  = get_cnt_from_url(url_item['url'])
  html = markdown_to_html(cnt)
  # read more is '---'
  html.gsub!(/<hr>/, '<!--more-->')

  
  blog_domain = @config['blog']
  wp_post_id  = url_item['wp_id']
  wp_login    = params[:login]
  wp_pwd      = params[:password]

  post = {}
  # post['title'] = '...'
  post['description'] = html
  publish_to_wp(blog_domain, wp_post_id, post, wp_login, wp_pwd)

  redirect '/'
end

get '/try' do
  haml :try
end

post '/try' do
  cnt  = get_cnt_from_url(params[:url])
  html = markdown_to_html(cnt)
  # read more is '---'
  html.gsub!(/<hr>/, '<!--more-->')

  blog_domain = params[:blog]
  wp_post_id  = params[:wp_id]
  wp_login    = params[:login]
  wp_pwd      = params[:password]

  post = {}
  # post['title'] = '...'
  post['description'] = html
  publish_to_wp(blog_domain, wp_post_id, post, wp_login, wp_pwd)

  redirect '/try'
end