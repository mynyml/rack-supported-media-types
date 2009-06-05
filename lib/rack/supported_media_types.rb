module Rack
  class SupportedMediaTypes

    #--
    # NOTE
    # Ths reason for adding nil to the list of accepted mime types:
    #
    #   "If no Accept header field is present, then it is assumed that the client accepts all media types"
    #    http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html
    #
    # Counter intuitive?
    #
    def initialize(app, mime_types)
      @app, @mime_types = app, mime_types.push(nil)
    end

    #--
    # return any headers with 406?
    def call(env)
      @mime_types.include?(accept(env)) ?
        @app.call(env) :
        Rack::Response.new([], 406).finish
    end

    private
      #--
      # First content-type in Accept header's list, without params
      def accept(env)
        header = env['HTTP_ACCEPT']

        (header.nil? || header.empty?) ?
          header :
          header.split(',').first.split(';').first
      end
  end
end
