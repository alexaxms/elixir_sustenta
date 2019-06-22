defmodule Sustenta.Survey.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "survey_answers" do
    field :answer, :string
    field :raw_score, :integer
    field :type, :integer
    belongs_to :question, Sustenta.Survey.Question

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:answer, :raw_score, :type])
    |> validate_required([:answer, :raw_score, :type])
  end
end
