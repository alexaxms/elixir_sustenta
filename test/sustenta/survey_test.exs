defmodule Sustenta.SurveyTest do
  use Sustenta.DataCase

  alias Sustenta.Survey

  describe "survey_questions" do
    alias Sustenta.Survey.Question

    @valid_attrs %{question: "some question", type: 42}
    @update_attrs %{question: "some updated question", type: 43}
    @invalid_attrs %{question: nil, type: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Survey.create_question()

      question
    end

    test "list_survey_questions/0 returns all survey_questions" do
      question = question_fixture()
      assert Survey.list_survey_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Survey.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Survey.create_question(@valid_attrs)
      assert question.question == "some question"
      assert question.type == 42
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Survey.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = Survey.update_question(question, @update_attrs)
      assert question.question == "some updated question"
      assert question.type == 43
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Survey.update_question(question, @invalid_attrs)
      assert question == Survey.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Survey.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Survey.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Survey.change_question(question)
    end
  end
end
