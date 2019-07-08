defmodule Sustenta.Repo.Migrations.AddColumnsToCompany do
  use Ecto.Migration

  def change do
    alter table(:user_companies) do
      add :social_reason, :string
      add :rut, :string
      add :website, :string
      add :email, :string
      add :agent, :string
      add :phone, :string
      add :address, :string
      add :type, :string
      add :aim, :integer
      add :branches, :integer
      add :start_of_activities, :string
      add :code, :string
      add :business_activity, :integer
      add :size, :integer
      add :offer, :integer
      add :region, :integer
      add :statement, :string
    end
  end
end
