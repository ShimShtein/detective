# frozen_string_literal: true

require 'sinatra/base'
require_relative 'configuration'

module Detective
  module Web
    # This is the main endpoint that exposes rubocop as a rack application
    class Endpoint < Sinatra::Base
      register Configuration

      configure :development do
        require 'sinatra/reloader'
        register Sinatra::Reloader
      end

      get '/cops' do
        content_type :json
        cops_classes = launcher.cops
        cops_classes.map(&:name).to_json
      end

      post '/run' do
        content_type :json
        payload = JSON.parse(request.body.read)
        result = launcher.run(
          cops_list: payload['cops_list'],
          content: payload['content'],
          filename: payload['filename']
        )
        result
      end
    end
  end
end
