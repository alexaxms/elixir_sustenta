defmodule Sustenta.Survey.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  import EnumsHelper

  enum "type" do
    %{
      default: 0,
      attachment: 1
    }
  end

  schema "survey_answers" do
    field :order, :integer
    field :answer, :string
    field :raw_score, :integer
    field :type, :integer
    belongs_to :question, Sustenta.Survey.Question

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:order, :answer, :raw_score, :type])
    |> validate_required([:order, :answer, :raw_score, :type])
  end
end
