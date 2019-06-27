defmodule Sustenta.Repo.Migrations.CreateConfigSurveyTemplates do
  use Ecto.Migration

  def change do
    create table(:config_survey_templates) do
      add :name, :string
      add :active, :boolean, default: false, null: false
      add :standard_id, references(:config_standards, on_delete: :nothing)

      timestamps()
    end

    create index(:config_survey_templates, [:standard_id])
  end
end
