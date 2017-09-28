# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :slack_posting,
  ecto_repos: [SlackPosting.Repo]

# Configures the endpoint
config :slack_posting, SlackPostingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/wMEvNXnbSEJIuyf9l0z0/IvkOV0n2Wg8FjSrGKxy6AAD3X9ThGhLPY0wN4PzsYD",
  render_errors: [view: SlackPostingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SlackPosting.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


config :ex_admin,
  repo: SlackPosting.Repo,
  module: SlackPosting,    # MyProject.Web for phoenix >= 1.3.0-rc
  modules: [
    SlackPosting.ExAdmin.Dashboard,
    SlackPosting.ExAdmin.Post
  ]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :xain, :after_callback, {Phoenix.HTML, :raw}

