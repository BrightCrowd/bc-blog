# Based on https://github.com/jgarber623/sixtwothree.org/blob/b3891aff/src/_plugins/json_page_generator.rb
# and https://stackoverflow.com/questions/14759827/jekyll-generating-json-files-alongside-the-html-files
# but using the json feed format: https://github.com/lildude/jekyll-json-feed
module Jekyll
  class JSONPage < Page
    def initialize(site, base, dir, name, content)
      @site = site
      @base = base
      @dir  = dir
      @name = name

      self.data = {}
      self.content = content

      process(@name)
    end

    def read_yaml(*)
      # Do nothing
    end

    def render_with_liquid?
      false
    end
  end

  class JSONPostGenerator < Generator
    safe true

    def generate(site)


      site.posts.docs.each do |post|
        # Converter for .md > .html
        converter = site.find_converter_instance(Jekyll::Converters::Markdown)
        filters = Jekyll::Filters

        # Set the path to the JSON version of the post
        dest = site.config['destination']
        path = post.destination(dest)
        path["#{dest}/"] = ''
        path['/index.html'] = '.json'

        # Convert the post to a hash
        output = {}
        output['id'] = site.config['url'] + site.baseurl + post.id
        output['url'] = site.config['url'] + site.baseurl + post.url
        output['title'] = post.data['title']
        output['content'] = converter.convert(post.content)
        output['summary'] = post.data['excerpt']
        output['image'] = site.config['url'] + site.baseurl + (post.data['image']['path'] || post.data['image'])
        # output['banner_image'] = post.data['banner_image']['path'] || post.data['banner_image']
        output['date_published'] = post.data['date'].xmlschema
        output['date_modified'] = (post.data['last_modified_at'] && post.data['last_modified_at'].xmlschema) || post.data['date'].xmlschema
        output['author'] = site.data['authors'][post.data['author']]
        output['tags'] = post.data['tags']


        site.pages << JSONPage.new(site, site.source, File.dirname(path), File.basename(path), output.to_json)
      end
    end
  end
end
