defmodule Sustenta.Users.Company do
  use Ecto.Schema
  import Ecto.Changeset
  import EnumsHelper

  enum "aim" do
    %{
      profitable: 0,
      not_profitable: 1,
    }
  end

  enum "offer" do
    %{
      services: 0,
      products_without_process: 1,
      products_with_process: 1
    }
  end

  enum "business_activity" do
    %{
      services: 0,
      products_without_process: 1,
      products_with_process: 1
    }
  end

  enum "company_size" do
    %{
      small: 0,
      medium: 1,
      big: 1
    }
  end

  schema "user_companies" do
    field :name, :string
    field :social_reason, :string
    field :rut, :string
    field :website, :string
    field :email, :string
    field :agent, :string
    field :phone, :string
    field :address, :string
    field :type, :string
    field :aim, :integer
    field :branches, :integer
    field :start_of_activities, :string
    field :code, :string
    field :business_activity, :integer
    field :size, :integer
    field :offer, :integer
    field :region, :integer
    field :statement, :string

    timestamps()
    belongs_to :user, Sustenta.Users.User
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :social_reason, :rut, :website, :email, :agent, :phone, :address, :type, :aim, :branches,
    :start_of_activities, :code, :business_activity, :size, :offer, :region, :statement])
    |> validate_required([:name, :social_reason, :rut, :website, :email, :agent, :phone, :address, :type, :aim, :branches,
    :start_of_activities, :code, :business_activity, :size, :offer, :region, :statement])
  end
end
