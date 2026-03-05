# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Only set up Bootsnap if not explicitly disabled
unless ENV['DISABLE_BOOTSNAP'] == '1'
  require 'bootsnap'

  env = ENV['RAILS_ENV'] ||= 'development'

  # Custom Bootsnap setup – disable ISeq caching in test
  Bootsnap.setup(
    cache_dir:            File.expand_path('tmp/cache', __dir__),
    development_mode:     env == 'development',
    load_path_cache:      true,                 # safe in all environments
    autoload_paths_cache: true,                 # safe in all environments
    compile_cache_iseq:   env != 'test',        # 🔥 DISABLE in test
    compile_cache_yaml:   env != 'test'         # optional: also disable YAML cache in test
  )
end
