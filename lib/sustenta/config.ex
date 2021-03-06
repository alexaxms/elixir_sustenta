defmodule Sustenta.Config do
  @moduledoc """
  The Config context.
  """

  import Ecto.Query, warn: false
  import Ecto
  alias Sustenta.Repo

  alias Sustenta.Config.{Ambit, Standard, SurveyTemplate}
  alias Sustenta.Config

  @doc """
  Returns the list of config_ambits.

  ## Examples

      iex> list_config_ambits()
      [%Ambit{}, ...]

  """
  def list_config_ambits do
    Repo.all(Ambit)
  end

  def list_ambits_with_standards do
    Config.list_config_ambits |> Repo.preload([:standards])
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

  def get_ambit_with_children!(id) do
    get_ambit_with_standards!(id)
    |> Repo.preload([:survey_templates])
  end
  
  def get_ambit_with_standards!(id), do: get_ambit!(id) |> Repo.preload([standards: (from s in Standard, order_by: s.number)])

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
  def get_standard!(id) do 
    Repo.get!(Standard, id) 
    |> Repo.preload([:ambit])
  end
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

  @doc """
  Returns the list of config_survey_templates.

  ## Examples

      iex> list_config_survey_templates()
      [%SurveyTemplate{}, ...]

  """
  def list_survey_templates(ambit), do: Repo.all(assoc(ambit, :survey_templates))

  @doc """
  Gets a single survey_template.

  Raises `Ecto.NoResultsError` if the Survey template does not exist.

  ## Examples

      iex> get_survey_template!(123)
      %SurveyTemplate{}

      iex> get_survey_template!(456)
      ** (Ecto.NoResultsError)

  """
  def get_survey_template!(id), do: Repo.get!(SurveyTemplate, id)

  @doc """
  Creates a survey_template.

  ## Examples

      iex> create_survey_template(%{field: value})
      {:ok, %SurveyTemplate{}}

      iex> create_survey_template(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_survey_template(ambit, attrs \\ %{}) do
    ambit
    |> build_assoc(:survey_templates)
    |> SurveyTemplate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a survey_template.

  ## Examples

      iex> update_survey_template(survey_template, %{field: new_value})
      {:ok, %SurveyTemplate{}}

      iex> update_survey_template(survey_template, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_survey_template(%SurveyTemplate{} = survey_template, attrs) do
    survey_template
    |> SurveyTemplate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SurveyTemplate.

  ## Examples

      iex> delete_survey_template(survey_template)
      {:ok, %SurveyTemplate{}}

      iex> delete_survey_template(survey_template)
      {:error, %Ecto.Changeset{}}

  """
  def delete_survey_template(%SurveyTemplate{} = survey_template) do
    Repo.delete(survey_template)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking survey_template changes.

  ## Examples

      iex> change_survey_template(survey_template)
      %Ecto.Changeset{source: %SurveyTemplate{}}

  """

  def change_survey_template(survey_template), do: SurveyTemplate.changeset(survey_template, %{})

  def build_survey_template(ambit) do 
    ambit
    |> build_assoc(:survey_templates)
    |> SurveyTemplate.changeset(%{})
  end
end
