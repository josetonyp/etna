# frozen_string_literal: true

module Etna
  module Concerns
    module ApiResponse
      def self.included(klass)
        klass.extend(Forwardable)

        klass.def_delegators :@body, *(Hash.instance_methods - Object.instance_methods)
        klass.def_delegators :@body, :key?, :has_key?

        klass.attr_reader :body
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
        if (@code == :ok && @status != 200) || @code.nil?
          Etna::Components::HTTP_CODES[@status]
        else
          @code
        end
      end
    end
  end
end
