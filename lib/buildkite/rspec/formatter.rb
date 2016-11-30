require "rspec/core/formatters/base_text_formatter"

module Buildkite
  module RSpec
    class Formatter < ::RSpec::Core::Formatters::DocumentationFormatter

      ::RSpec::Core::Formatters.register(self, :example_started, :example_group_started, :example_failed)

      def example_group_started(notification)
        output.puts "--- #{current_indentation}#{notification.group.description}"
        super
      end

      def example_started(notification)
        output.puts "--- #{notification.example.group.full_description} #{notification.example.description}" if ENV['RSPEC_BREAK_ON_EXAMPLE']
      end

      def example_failed(notification)
        super
        output.puts(notification.fully_formatted)
        output.puts("^^^ +++")
      end
    end
  end
end
