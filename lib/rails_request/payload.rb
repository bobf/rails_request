# frozen_string_literal: true

module RailsRequest
  class Payload
    def initialize(payload)
      @payload = payload
    end

    def curl_options
      query = params.present? ? "?#{params.to_query}" : nil
      # host and port set during request by before_action
      host = RailsRequest.host
      port = RailsRequest.port
      [
        'curl',
        '-v',
        "--request '#{method}'",
        headers.map { |key, value| "--header '#{key}: #{value}'" },
        "'http://#{host}:#{port}#{path}#{query}'"
      ].flatten.join(" \\\n")
    end

    def path
      @payload[:path]
    end

    def method
      @payload[:method]
    end

    private

    def headers
      return [] if @payload[:headers].nil?

      @payload[:headers]
        .select { |key, *_| key.start_with?('HTTP') }
        .map do |key, value|
          segments = key.downcase.split('_')
          segments.shift
          reformatted = segments.map(&:capitalize).join('-')
          [reformatted, value]
        end
    end

    def params
      Hash[@payload[:params].reject do |key, _|
        %w[action controller path].include?(key)
      end]
    end
  end
end
