defmodule Sustenta.Survey.Question do
  use Ecto.Schema
  import Ecto.Changeset
  import EnumsHelper

  enum "type" do
    %{
      single: 0,
      multi: 1
    }
  end

  schema "survey_questions" do
    field :question, :string
    field :type, :integer
    has_many :answers, Sustenta.Survey.Answer

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question, :type])
    |> validate_required([:question, :type])
  end

end
