# Based on https://github.com/jgarber623/sixtwothree.org/blob/b3891aff/src/_plugins/json_page_generator.rb
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
        # puts post.content
        # puts post.data
        # p post.destination(dest)
        # Set the path to the JSON version of the post
        dest = site.config['destination']
        path = post.destination(dest)
        path["#{dest}/"] = ''
        path['/index.html'] = '.json'

        # Convert the post to a hash
        output = post.data.clone

        # Prepare the output for JSON conversion
        ['dir', 'layout', 'path'].each do |key|
          output.delete(key)
        end


        output['content'] = post.content.clone
        # output['next'] = output['next'].id unless output['next'].nil?
        # output['previous'] = output['previous'].id unless output['previous'].nil?

        site.pages << JSONPage.new(site, site.source, File.dirname(path), File.basename(path), output.to_json)
      end
    end
  end
end
