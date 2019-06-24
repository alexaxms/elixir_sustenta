defmodule Sustenta.Survey do
  @moduledoc """
  The Survey context.
  """

  import Ecto.Query, warn: false
  import Ecto
  alias Sustenta.Repo

  alias Sustenta.Survey.Question
  alias Sustenta.Survey.Answer

  @doc """
  Returns the list of survey_questions.

  ## Examples

      iex> list_survey_questions()
      [%Question{}, ...]

  """
  def list_survey_questions, do: Repo.all(Question)

  @doc """
  Gets a single question.

  Raises if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

  """
  def get_question!(id), do: Repo.get(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, ...}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, ...}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, ...}

  """
  def delete_question(%Question{} = question), do: Repo.delete(question)

  @doc """
  Returns a data structure for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Todo{...}

  """
  def change_question(%Question{} = question), do: Question.changeset(question, %{})

  ## Answer
  @doc """
  Returns the list of survey_answers.

  ## Examples

      iex> list_survey_answers()
      [%Question{}, ...]

  """
  def list_survey_answers(question), do: Repo.all(assoc(question, :answers))

end
