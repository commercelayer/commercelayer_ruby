require "jsonapi/consumer"
require "jsonapi/consumer/decorators"
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
    # Define base resource classes
    resource_class_name = resource_values[:name].to_s.classify
    resource_class = Class.new(Resource) do
      resource_values[:relationships].each do |name, options|
        send options[:type], name, class_name: options[:class_name]
      end
    end
    Commercelayer.const_set(resource_class_name, resource_class)

    # Define relationship resource classes
    resource_values[:relationships].each do |name, options|
      relationship_resource_class_name = name.to_s.classify
      if !resources.keys.include?(name.to_s.singularize.to_sym) && !Object.const_defined?("Commercelayer::#{relationship_resource_class_name}")
        relationship_resource_class = Class.new(Resource)
        Commercelayer.const_set(relationship_resource_class_name, relationship_resource_class)
      end
    end
  end

end
