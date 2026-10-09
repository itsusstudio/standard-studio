module Standard
  module Studio
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: "standard-studio",
          version: VERSION,
          homepage: "https://github.com/itsusstudio/standard-studio",
          description: "ITSUSSTUDIO rules for Standard Ruby"
        )
      end

      def supported?(context)
        true
      end

      def rules(context)
        LintRoller::Rules.new(
          type: :path,
          config_format: :rubocop,
          value: Pathname.new(__dir__).join("../../../config/base.yml")
        )
      end
    end
  end
end
