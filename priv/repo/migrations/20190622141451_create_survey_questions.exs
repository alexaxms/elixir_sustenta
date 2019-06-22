defmodule Sustenta.Repo.Migrations.CreateSurveyQuestions do
  use Ecto.Migration

  def change do
    create table(:survey_questions) do
      add :question, :string
      add :type, :integer

      timestamps()
    end

  end
end
