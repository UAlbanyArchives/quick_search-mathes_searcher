#Try to load a local version of the config file if it exists - expected to be in quicksearch_root/config/searchers/<my_searcher_name>_config.yml

if File.exists?(File.join(Rails.root, "/config/searchers/mathes_config.yml"))
  config_file = File.join Rails.root, "/config/searchers/mathes_config.yml"
else
  # otherwise load the default config file
  config_file = File.expand_path("../../mathes_config.yml", __FILE__)
end
QuickSearch::Engine::MATHES_CONFIG = YAML.load_file(config_file)[Rails.env]