defmodule Sustenta.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()

    timestamps()
    has_one :company, Sustenta.Users.Company
  end
end
