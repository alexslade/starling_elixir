# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

import_config "config.secret.exs"

config :starling, endpoint: "https://api-sandbox.starlingbank.com"

if Mix.env == :test do
  config :exvcr, [
    vcr_cassette_library_dir: "test/fixtures/vcr_cassettes",
    filter_sensitive_data: [
      [pattern: "Bearer .+", placeholder: "<<<ACCESS_TOKEN_FILTERED>>>"]
    ]
  ]
end
# Uncomment to enable per-env config files
#   import_config "#{Mix.env}.exs"

