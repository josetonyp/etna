# frozen_string_literal: true

module Etna
  module Concerns
    module Logger
      private

      def person_params(options)
        options[:person_id] = @configuration.person_id if @configuration.person_id

        {
          person: {
            person_id: options.fetch(:person_id, {}),
            time: Time.now,
            environment: options.fetch(:environment, 'test'),
          },
        }
      end

      def log(client_response, person_params = {})
        @logger&.info(log_content(client_response, person_params).to_json)
      end

      def log_content(client_response, person_params = {})
        client_response.to_h.merge(person_params)
      end
    end
  end
end
