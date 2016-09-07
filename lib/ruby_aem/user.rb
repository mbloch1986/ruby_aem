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
  class User

    # Initialise a user
    #
    # @param client RubyAem::Client
    # @param path the path to user node, e.g. /home/users/s/
    # @param name the username of the AEM user, e.g. someuser, admin, johncitizen
    def initialize(client, path, name)
      @client = client
      @info = {
        path: path,
        name: name
      }
    end

    def create(password)
      @info[:password] = password
      if !@info[:path].match(/^\//)
        @info[:path] = "/#{@info[:path]}"
      end
      @client.call(self.class, __callee__.to_s, @info)
    end

    def delete()
      result = find_authorizable_id
      if result.data
        @info[:path] = RubyAem::Swagger.path(@info[:path])
        @client.call(self.class, __callee__.to_s, @info)
      else
        result
      end
    end

    def exists()
      @info[:path] = RubyAem::Swagger.path(@info[:path])
      @client.call(self.class, __callee__.to_s, @info)
    end

    def set_permission(permission_path, permission_csv)
      @info[:permission_path] = permission_path
      @info[:permission_csv] = permission_csv
      @client.call(self.class, __callee__.to_s, @info)
    end

    def add_to_group(group_path, group_name)
      group = RubyAem::Group.new(@client, group_path, group_name)
      group.add_member(@info[:name])
    end

    def change_password(old_password, new_password)
      @info[:old_password] = old_password
      @info[:new_password] = new_password
      @client.call(self.class, __callee__.to_s, @info)
    end

    def find_authorizable_id()
      @client.call(self.class, __callee__.to_s, @info)
    end

  end
end
