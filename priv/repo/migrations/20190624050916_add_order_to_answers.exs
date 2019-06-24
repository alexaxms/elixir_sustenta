defmodule Sustenta.Repo.Migrations.AddOrderToAnswers do
  use Ecto.Migration

  def change do
    alter table(:survey_answers) do
      add :order, :integer
    end
  end
end
