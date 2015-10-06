require 'bundler/setup'
require 'rack/rewrite'
require 'pathname'
require 'json'
require 'blade'

root = Pathname.new(File.dirname(__FILE__))

require root.join('lib/trix/environment')
environment = Trix::Environment.new(root)
environment.paths = %w( assets polyfills src )

use Blade::RackAdapter, mount: '/test'

map '/' do
  run environment.sprockets_environment
  use Rack::Rewrite do
    rewrite '/', '/index.html'
  end
end

map '/submit' do
  run -> (env) do
    request = Rack::Request.new(env)
    response = JSON.dump(request.params)
    [200, {'Content-Type' => 'application/json'}, [response]]
  end
end
