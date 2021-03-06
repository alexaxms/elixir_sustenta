# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sustenta,
  ecto_repos: [Sustenta.Repo]

# Configures the endpoint
config :sustenta, SustentaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vTWYoDEIYgKhHzTraqFzmm2Ib1K0hJM/ZkXvaq+Qv7HpLplzhM59TRsnlrYOBoWp",
  render_errors: [view: SustentaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sustenta.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :sustenta, SustentaWeb.Gettext, default_locale: "es"

config :sustenta, :pow,
  user: Sustenta.Users.User,
  repo: Sustenta.Repo,
  web_module: SustentaWeb

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine,
  slimleex: PhoenixSlime.LiveViewEngine  

config :phoenix_slime, :use_slim_extension, true
  