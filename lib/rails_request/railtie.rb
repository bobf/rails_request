# frozen_string_literal: true

ActiveSupport.on_load(:action_controller) do
  include RailsRequest::ApplicationControllerExtension
end

module RailsRequest
  class Railtie < Rails::Railtie
    initializer 'rails_request.subscribe' do |_app|
      event = 'process_action.action_controller'
      notifications = ActiveSupport::Notifications
      notifications.subscribe(event) do |_unused, start, _unused, _unused, data|
        payload = Payload.new(data)
        path = Pathname.new(Dir.tmpdir)
                       .join(start.strftime('%Y-%m-%d--%H-%M-%S.curl'))
        File.write(path, payload.curl_options)
        output(payload, path)
      end
    end

    def output(payload, path)
      green = "\033[32m"
      blue = "\033[33m"
      yellow = "\033[34m"
      cyan = "\033[36m"
      reset = "\033[0m"

      command = %(eval "$(cat '#{path}')")
      prefix = "#{cyan}#{payload.method} #{blue}#{payload.path}"
      puts "#{prefix}#{reset} | #{yellow}replay request:#{reset}"
      puts "#{green}#{command}#{reset}"
      puts
    end
  end
end
