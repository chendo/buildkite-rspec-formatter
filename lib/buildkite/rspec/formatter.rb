require "rspec/core/formatters/base_text_formatter"
begin
  require "capybara-inline-screenshot/rspec"
rescue LoadError
end

module Buildkite
  module RSpec
    class Formatter < ::RSpec::Core::Formatters::DocumentationFormatter

      ::RSpec::Core::Formatters.register(self, :example_started, :example_group_started, :example_failed)
      def initialize(output)
        super
        @max_depth = ENV.fetch('BUILDKITE_RSPEC_MAX_DEPTH', 2).to_i
        @break_on_example = !!ENV['BUILDKITE_RSPEC_BREAK_ON_EXAMPLE']
      end

      def example_group_started(notification)
        output.puts "--- #{prefix} #{notification.group.description}" if (@group_level + 1) <= @max_depth
        super
      end

      def example_started(notification)
        output.puts "--- #{prefix} #{notification.example.description}" if @break_on_example
      end

      def example_failed(notification)
        output.puts "+++ #{prefix} #{notification.example.description}" unless @break_on_example
        output.print "   " # Make the output line up
        super
        output.puts(notification.colorized_message_lines.join("\n"))
        output.puts(notification.colorized_formatted_backtrace.join("\n"))

        if defined?(CapybaraInlineScreenshot) && screenshot = notification.example.metadata[:screenshot]
          output.puts CapybaraInlineScreenshot.escape_code_for_image(screenshot[:image]) if screenshot[:image]
        end
        output.puts "^^^ +++" if @break_on_example
        output.puts "--- –––"
      end

      private def prefix
        return "┏" if @group_level == 0
        "#{'  ' * [@group_level - 1, 0].max}┣━"
      end
    end
  end
end
