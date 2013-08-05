OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

helpers do

  def get_cnt_from_url(url)
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

end