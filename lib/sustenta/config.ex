defmodule Sustenta.Config do
  @moduledoc """
  The Config context.
  """

  import Ecto.Query, warn: false
  import Ecto
  alias Sustenta.Repo

  alias Sustenta.Config.Ambit

  @doc """
  Returns the list of config_ambits.

  ## Examples

      iex> list_config_ambits()
      [%Ambit{}, ...]

  """
  def list_config_ambits do
    Repo.all(Ambit)
  end

  @doc """
  Gets a single ambit.

  Raises `Ecto.NoResultsError` if the Ambit does not exist.

  ## Examples

      iex> get_ambit!(123)
      %Ambit{}

      iex> get_ambit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ambit!(id), do: Repo.get!(Ambit, id)

  @doc """
  Creates a ambit.

  ## Examples

      iex> create_ambit(%{field: value})
      {:ok, %Ambit{}}

      iex> create_ambit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ambit(attrs \\ %{}) do
    %Ambit{}
    |> Ambit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ambit.

  ## Examples

      iex> update_ambit(ambit, %{field: new_value})
      {:ok, %Ambit{}}

      iex> update_ambit(ambit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ambit(%Ambit{} = ambit, attrs) do
    ambit
    |> Ambit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ambit.

  ## Examples

      iex> delete_ambit(ambit)
      {:ok, %Ambit{}}

      iex> delete_ambit(ambit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ambit(%Ambit{} = ambit) do
    Repo.delete(ambit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ambit changes.

  ## Examples

      iex> change_ambit(ambit)
      %Ecto.Changeset{source: %Ambit{}}

  """
  def change_ambit(%Ambit{} = ambit) do
    Ambit.changeset(ambit, %{})
  end

  alias Sustenta.Config.Standard

  @doc """
  Returns the list of config_standards.

  ## Examples

      iex> list_config_standards()
      [%Standard{}, ...]

  """
  def list_standards(ambit), do: Repo.all(assoc(ambit, :standards))

  @doc """
  Gets a single standard.

  Raises `Ecto.NoResultsError` if the Standard does not exist.

  ## Examples

      iex> get_standard!(123)
      %Standard{}

      iex> get_standard!(456)
      ** (Ecto.NoResultsError)

  """
  def get_standard!(id), do: Repo.get!(Standard, id)

  @doc """
  Creates a standard.

  ## Examples

      iex> create_standard(%{field: value})
      {:ok, %Standard{}}

      iex> create_standard(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_standard(ambit, attrs \\ %{}) do
    ambit
    |> build_assoc(:standards)
    |> Standard.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a standard.

  ## Examples

      iex> update_standard(standard, %{field: new_value})
      {:ok, %Standard{}}

      iex> update_standard(standard, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_standard(%Standard{} = standard, attrs) do
    standard
    |> Standard.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Standard.

  ## Examples

      iex> delete_standard(standard)
      {:ok, %Standard{}}

      iex> delete_standard(standard)
      {:error, %Ecto.Changeset{}}

  """
  def delete_standard(%Standard{} = standard), do: Repo.delete(standard)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking standard changes.

  ## Examples

      iex> change_standard(standard)
      %Ecto.Changeset{source: %Standard{}}

  """
  def change_standard(standard), do: Standard.changeset(standard, %{})

  def build_standard(ambit) do 
    ambit
    |> build_assoc(:standards)
    |> Standard.changeset(%{})
  end
end
