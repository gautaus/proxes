# frozen_string_literal: true
require 'rack'
require 'proxes/request'

module ProxES
  class Request
    class Search < ProxES::Request
      attr_accessor :index
      attr_reader :type

      def endpoint
        '_search'
      end

      def parse
        @index ||= check_part(path_parts[0])
        @type  ||= check_part(path_parts[1])
        @id    ||= check_part(path_parts[2])
      end

      def id
        @id == [] ? nil : @id
      end

      def indices?
        true
      end
    end
  end
end
