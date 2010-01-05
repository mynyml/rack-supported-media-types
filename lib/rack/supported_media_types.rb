require 'rack/accept_media_types'

module Rack
  class SupportedMediaTypes

    def initialize(app, mime_types)
      @app, @mime_types = app, mime_types
    end

    #--
    # return any headers with 406?
    def call(env)
      req_type = accept(env)
      !req_type.empty? && @mime_types.any? {|type| type.match(/#{req_type}/) } ?
        @app.call(env) :
        Rack::Response.new([], 406).finish
    end

    private
      #--
      # Client's prefered media type.
      #
      # NOTE
      # glob patterns are replaced with regexp.
      #
      #   */*     ->  .*/.*
      #   text/*  ->  text/.*
      #
      # NOTE
      # Rack::AcceptMediaTypes.prefered is */* if Accept header is nil
      #
      def accept(env)
        Rack::AcceptMediaTypes.new(env['HTTP_ACCEPT']).prefered.to_s.gsub(/\*/, '.*')
      end
  end
end
