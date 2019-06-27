defmodule Sustenta.Config.SurveyTemplate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "config_survey_templates" do
    field :active, :boolean, default: false
    field :name, :string
    belongs_to :standard, Sustenta.Config.Standard

    timestamps()
  end

  @doc false
  def changeset(survey_template, attrs) do
    survey_template
    |> cast(attrs, [:name, :active])
    |> validate_required([:name, :active])
  end
end
