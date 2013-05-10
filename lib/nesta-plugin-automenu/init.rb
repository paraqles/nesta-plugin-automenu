module Nesta
  module Plugin
    module AutoMenu

      require 'rubygems'
      require 'tilt'

      @std_options = {
        template:       "../templates/list_menu.haml"
      }
      @menu_ignore_names = [".menu_ignore", ".ignore"]

      def self.menu(params={})

        if params.include? :template
          template = Nesta::Path.themes(
                      Nesta::Config.yaml_conf["theme"], params[:template] )
        else
          template = @std_options[:template]
        end

        if params.include? :path
          path = Nesta::Path.local(
                  File.join(
                    Nesta::Config.content_path, "pages", params[:path] ) )
        else
          path = Nesta::Path.local(
                  File.join( Nesta::Config.content_path, "pages" ) )
        end

        ignore = params.fetch(:ignore, [])

        content = collect_entries_for( path, ignore )
        puts content

        Tilt.new( template ).render( Nesta::App, entries: content )
      end

      private
      def self.ignores_for(path)
        @ignores = []

        @menu_ignore_names.each do |ig_name|
          if File.exist? File.join(path, ig_name)
            File.open(ig_name) do |f|
              f.each_line do |line|
                @ignores << line
              end
            end
          end
        end

        return @ignores
      end

      private
      def self.should_ignored?(element, ignore)
        ignore.each do |pattern|
          return true if pattern =~ element
        end
        return false
      end

      private
      def self.url_for( path )
        url = ""

        content_path = Nesta::Path.local [Nesta::Config.content_path, "pages"]

        url = path[/^#{content_path}(\/.*)$/, 1]
        url.sub!(/index(\.\w+)?$/i, "") if url =~ /\/index(\.\w+)?$/i

        url.sub!(/\.\w+$/i, "")

        return url
      end

      private
      def self.collect_entries_for( path, ignore, path_ignores=[])
        current = []

        Dir.foreach( path ) do |element|
          next if self.should_ignored?(element, path_ignores)
          next if self.should_ignored?(element, ignore)

          ele_abs = File.expand_path( element, path )

          if File.directory? ele_abs
            next if element =~ /(^\.{1,2}$)/

            path_ignores = self.ignores_for ele_abs

            sub = self.collect_entries_for( ele_abs, ignore, path_ignores)
            title = element

          elsif File.file? ele_abs \
          and not @menu_ignore_names.include? element \
          and element[0] != "."
            title = element.split( "." )[0]

          else
            title = element
          end

          url = self.url_for ele_abs
          entry = {url: url, title: title.capitalize}
          entry[:sub] = sub if sub != nil and not sub.empty?
          current << entry
        end

        return current
      end

      module Helpers
      end
    end
  end

  class App
    helpers Nesta::Plugin::AutoMenu::Helpers
  end
end
