xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  sitemap.resources.each do |resource|
    next if resource.destination_path !~ /\.html$/
    next if resource.destination_path =~ /^google/

    xml.url do
      xml.loc "https://youcube.jp#{resource.url}"
    end
  end
end
