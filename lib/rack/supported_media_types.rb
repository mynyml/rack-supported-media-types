module Rack
  class SupportedMediaTypes

    def initialize(app, mime_types)
      @app, @mime_types = app, mime_types
    end

    # --
    # return any headers with 415?
    def call(env)
      @mime_types.include?(accept(env)) ?
        @app.call(env) :
        Rack::Response.new([], 415).finish
    end

    private
      #--
      # First content-type in Accept header's list, without params
      def accept(env)
        if env['HTTP_ACCEPT'] && !env['HTTP_ACCEPT'].empty?
           env['HTTP_ACCEPT'].split(',').first.split(';').first
        end
      end
  end
end
