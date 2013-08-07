require 'open-uri'
require 'openssl'
require 'redcarpet'
require 'xmlrpc/client'
require 'yaml'

# open https
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

helpers do

  def reload_config
    $config_cnt = nil
  end

  def init_config
    @password = ENV['github2wp-pwd']

    # remote config
    if ENV['github2wp-config']
      config_cnt = $config_cnt || get_cnt_from_url(ENV['github2wp-config'])
      $config_cnt = config_cnt # cache
      @remote_config = ENV['github2wp-config']
    else
      config_cnt = open('config.yml').read
    end
    @config   = YAML.load(config_cnt)
    @blog_url = @config['blog'] ? 'http://' + @config['blog'] : ''
    @urls     = @config['urls'] || []
    @password = @password || @config['pass-word']
  end

  def get_cnt_from_url(url)
    p url
    open(url).read
  end

  def markdown_to_html(cnt)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown.render(cnt)
  end

  def publish_to_wp(blog_domain, wp_post_id, post, wp_login, wp_pwd)
    connection = XMLRPC::Client.new(blog_domain, '/xmlrpc.php')
    connection.call('metaWeblog.editPost', wp_post_id, wp_login, wp_pwd, post, true)
  end

  def github_row_link_to_human(link)
    human = link.gsub('raw.github.com', 'github.com').gsub('/master/', '/blob/master/')
    human
  end

end