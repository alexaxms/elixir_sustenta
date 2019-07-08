defmodule Sustenta.Repo.Migrations.AlterSurveyTemplatesTable do
  use Ecto.Migration

  def change do
    alter table(:config_survey_templates) do
      remove :standard_id
      add :ambit_id, references(:config_ambits, on_delete: :nothing)
    end

    create index(:config_survey_templates, [:ambit_id])
  end
end
