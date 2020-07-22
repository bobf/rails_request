# frozen_string_literal: true

require 'pathname'
require 'tempfile'
require 'rails'

require 'rails_request/version'
require 'rails_request/application_controller_extension'
require 'rails_request/railtie' if Rails.env.development?
require 'rails_request/payload'

module RailsRequest
  class Error < StandardError; end

  class << self
    attr_accessor :host, :port
  end
end
