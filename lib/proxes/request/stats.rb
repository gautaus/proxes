require 'rack'

module ProxES
  class Request
    class Stats < Base
      def has_indices?
        true
      end

      def parse
      end
    end
  end
end