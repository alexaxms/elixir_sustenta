defmodule Sustenta.Repo do
  use Ecto.Repo,
    otp_app: :sustenta,
    adapter: Ecto.Adapters.Postgres
end
