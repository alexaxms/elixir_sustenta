defmodule Sustenta.Config.Standard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "config_standards" do
    field :name, :string
    field :number, :integer
    belongs_to :ambit, Sustenta.Config.Ambit
    has_many :survey_templates, Sustenta.Config.SurveyTemplate 

    timestamps()
  end

  @doc false
  def changeset(standard, attrs) do
    standard
    |> cast(attrs, [:number, :name])
    |> validate_required([:number, :name])
  end
end
