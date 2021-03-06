require 'pronto'
require 'rubocop'
require 'standard'
require 'pronto/standardrb/patch_cop'
require 'pronto/standardrb/offense_line'

module Pronto
  class Standardrb < Runner
    def run
      ruby_patches
        .select { |patch| patch.additions > 0 }
        .flat_map { |patch| PatchCop.new(patch, self).messages }
    end

    def pronto_rubocop_config
      @pronto_rubocop_config ||= Pronto::ConfigFile.new.to_h['rubocop'] || {}
    end
  end
end
