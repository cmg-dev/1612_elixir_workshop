# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :wiki,
  ecto_repos: [Wiki.Repo]

# Configures the endpoint
config :wiki, Wiki.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tppzW6HXY9G75CZL+lnpqNNS+Q4ckC6rE3rrjIRdscTUlhEKNB9qrPby58VItsYF",
  render_errors: [view: Wiki.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Wiki.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
