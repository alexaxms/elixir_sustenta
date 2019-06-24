defmodule Sustenta.Config.Ambit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "config_ambits" do
    field :name, :string
    field :number, :integer
    has_many :standards, Sustenta.Config.Standard 
    
    timestamps()
  end

  @doc false
  def changeset(ambit, attrs) do
    ambit
    |> cast(attrs, [:number, :name])
    |> validate_required([:number, :name])
  end
end
