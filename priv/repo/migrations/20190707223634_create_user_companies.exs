defmodule Sustenta.Repo.Migrations.CreateUserCompanies do
  use Ecto.Migration

  def change do
    create table(:user_companies) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    
    create index(:user_companies, [:user_id])
  end
end
