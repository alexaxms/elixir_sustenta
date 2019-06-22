defmodule Sustenta.Repo.Migrations.CreateSurveyAnswers do
  use Ecto.Migration

  def change do
    create table(:survey_answers) do
      add :answer, :string
      add :raw_score, :integer
      add :type, :integer
      add :question_id, references(:survey_questions)

      timestamps()
    end

  end
end
