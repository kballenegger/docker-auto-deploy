
require 'kenji'
require './app'

run Kenji::App.new(root_controller: AutoDeployController,
                   auto_cors: false)
