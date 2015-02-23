###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
helpers do
  # active をつけるべきかどうか判断してつけるべきならつけたリンクを生成する
  # @param [String] label リンクラベル
  # @param [String] dest リンク先
  # @param [Hash] attr li に渡す属性
  def activity_list(label, dest, attr = {})
    if dest == current_page.url
      if attr.has_key?(:class)
        attr[:class] += ' active'
      else
        attr.merge!(class: 'active')
      end
    end

    content_tag(:li, attr) do
      link_to label, dest
    end
  end

  # FontAwesome
  def icon(icon, text="", html_options={})
    content_class = "fa fa-#{icon}"
    content_class << " #{html_options[:class]}" if html_options.key?(:class)
    html_options[:class] = content_class
    html = content_tag(:i, nil, html_options)
    html << " #{text}" unless text.blank?
    html.html_safe
  end

  # おしらせの YAML をハッシュに変換して返す
  def announcements
    YAML.load_file('resources/announcements.yml')
  end

  # image_url を返す
  def image_url(source)
    'https://youcube.jp' + image_path(source)
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# きれいな URL
activate :directory_indexes

# サイトマップは layout しない
page '/sitemap.xml', layout: false

# Build-specific configuration
configure :build do
  require 'uglifier'

  # Minify files
  activate :minify_html do |_|
    _.preserve_line_breaks = true
  end
  activate :minify_css
  activate :minify_javascript, compressor: Uglifier.new(comments: :none)

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
