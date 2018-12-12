# frozen_string_literal: true

module Etna
  module Concerns
    module ApiListResponse
      def self.included(klass)
        klass.extend(Forwardable)

        klass.def_delegators :@collection, *(Array.instance_methods - Object.instance_methods)

        klass.attr_reader :collection
      end

      def uid
        @uid ||= SecureRandom.hex(16)
      end

      def success?
        !@error
      end
      alias successful? success?

      def error?
        @error
      end
      alias failure? error?

      def code
        if @code == :ok && @status != 200
          Etna::Components::HTTP_CODES[@status]
        else
          @code
        end
      end
    end
  end
end
