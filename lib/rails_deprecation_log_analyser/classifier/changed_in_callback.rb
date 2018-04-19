# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ChangedInCallback < Base
      def match?(log_line)
        log_line.include?('The behavior of `changed?` inside of after callbacks will be changing in the next version of Rails.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: '"changed?" inside of after callbacks',
          summary: 'The behavior of `changed?` inside of after callbacks will be changing in the next version of Rails.',
          message: 'The behavior of `changed?` inside of after callbacks will be changing in the next version of Rails. The new return value will reflect the behavior of calling the method after `save` returned (e.g. the opposite of what it returns now). To maintain the current behavior, use `saved_changes?` instead.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
