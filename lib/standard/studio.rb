require "lint_roller"
require "rubocop"

module Standard
  module Studio
  end
end

require_relative "../rubocop/cop/studio/class_structure"
require_relative "studio/version"
require_relative "studio/plugin"
