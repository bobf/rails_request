# frozen_string_literal: true

module RailsRequest
  module ApplicationControllerExtension
    extend ActiveSupport::Concern

    included do
      before_action :__rails_request_capture_host_and_port
    end

    def __rails_request_capture_host_and_port
      RailsRequest.host = request.host
      RailsRequest.port = request.port
    end
  end
end
