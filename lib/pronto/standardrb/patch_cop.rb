module Pronto
  class Standardrb < Runner
    class PatchCop
      attr_reader :runner

      def initialize(patch, runner)
        @patch = patch
        @runner = runner
      end

      def messages
        return [] unless valid?

        offenses.flat_map do |offense|
          patch
            .added_lines
            .select { |line| line.new_lineno == offense.line }
            .map { |line| OffenseLine.new(self, offense, line).message }
        end
      end

      def processed_source
        @processed_source ||= ::RuboCop::ProcessedSource.from_file(
          path,
          rubocop_config.target_ruby_version
        )
      end

      def registry
        @registry ||= ::RuboCop::Cop::Registry.new(RuboCop::Cop::Cop.all)
      end

      def rubocop_config
        config = Standard::BuildsConfig.new.call([])

        @rubocop_config ||= config.rubocop_config_store.for(path)
      end

      private

      attr_reader :patch

      def valid?
        return false if rubocop_config.file_to_exclude?(path)
        return true if rubocop_config.file_to_include?(path)

        true
      end

      def path
        @path ||= patch.new_file_full_path.to_s
      end

      def offenses
        team
          .inspect_file(processed_source)
          .sort
          .reject(&:disabled?)
      end

      def team
        @team ||= ::RuboCop::Cop::Team.new(registry, rubocop_config)
      end
    end
  end
end
