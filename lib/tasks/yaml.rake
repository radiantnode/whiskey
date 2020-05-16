require 'json'
require 'yaml'

namespace :yaml do
  task :generate do
    puts JSON.parse(File.read(WHISKEY_JSON)).to_yaml
  end
end
