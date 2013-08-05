require 'rubygems'
require 'sinatra'

require 'helpers'


before do
  require 'yaml'
  @config = YAML.load(open('config.yml'))
  @blog_url = 'http://' + @config['blog']
  @urls     = @config['urls']
end

get '/' do
  erb :index
end

get '/update/:pos' do
  @pos = params[:pos]
  erb :update
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