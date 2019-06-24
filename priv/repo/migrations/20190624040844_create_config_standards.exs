defmodule Sustenta.Repo.Migrations.CreateConfigStandards do
  use Ecto.Migration

  def change do
    create table(:config_standards) do
      add :number, :integer
      add :name, :string
      add :ambit_id, references(:config_ambits, on_delete: :nothing)

      timestamps()
    end

    create index(:config_standards, [:ambit_id])
  end
end
