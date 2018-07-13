require "jsonapi/consumer"
require 'yaml'

module Commercelayer

  JSONAPI::Consumer::Paginating::Paginator.page_param = "page[number]"
  
  class Resource < JSONAPI::Consumer::Resource
    # self.connection_options = {} # Faraday connection options
    # self.json_key_format = :dasherized_key # (default: underscored_key)
    # self.route_format = :dasherized_route # (default: underscored_route)
    # self.site = 'http://uashmama.commercelayer.test/api/'
  end

  resources = YAML::load_file(File.join(__dir__, '../../config/resources.yml'))["resources"].deep_symbolize_keys

  resources.each do |resource_key, resource_values|
    resource_class = Class.new(Resource) do
      resource_values[:relationships].each do |name, options|
        send options[:type], name, class_name: options[:class_name]
      end
    end
    Commercelayer.const_set(resource_values[:name], resource_class)
  end

end
