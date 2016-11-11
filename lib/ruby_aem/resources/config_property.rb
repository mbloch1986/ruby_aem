=begin
Copyright 2016 Shine Solutions

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=end

module RubyAem
  module Resources
    # ConfigProperty class contains API calls related to managing an AEM config property.
    class ConfigProperty

      # Initialise a config property
      #
      # @param client RubyAem::Client
      # @param name the property's name
      # @param type the property's type, e.g. Boolean
      # @param value the property's value, e.g. true
      # @return new RubyAem::Resources::ConfigProperty instance
      def initialize(client, name, type, value)
        @client = client
        @call_params = {
          name: name,
          type: type,
          value: value
        }
      end

      # Create a new config property.
      #
      # @param run_mode AEM run mode: author or publish
      # @return RubyAem::Result
      def create(run_mode)

        name = RubyAem::Swagger.property_to_parameter(@call_params[:name])

        @call_params[:run_mode] = run_mode
        @call_params["#{name}".to_sym] = @call_params[:value]
        @call_params["#{name}_type_hint".to_sym] = @call_params[:type]

        @client.call(self.class, __callee__.to_s, @call_params)
      end

    end
  end
end