defmodule Sustenta.Repo.Migrations.CreateConfigAmbits do
  use Ecto.Migration

  def change do
    create table(:config_ambits) do
      add :number, :integer
      add :name, :string

      timestamps()
    end

  end
end
