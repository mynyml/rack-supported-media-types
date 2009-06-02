module Rack
  class SupportedMediaTypes
    def initialize(app, mime_types)
      @app, @mime_types = app, mime_types
    end

    def call(env)
      type = requested_mime_type(env)
      if @mime_types.include?(type)
        @app.call(env)
      else
        Rack::Response.new([], 415).finish
      end
    end

    def requested_mime_type(env)
      format = env['request.format']

      Rack::Mime::MIME_TYPES.values.include?(format) ?
        format :
        Rack::Mime.mime_type(format.sub(/^\./,'').insert(0,'.'), nil)
    end
  end
end
