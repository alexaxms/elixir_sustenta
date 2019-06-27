defmodule SustentaWeb.SurveyTemplateController do
  use SustentaWeb, :controller
  alias Sustenta.Config
  

  def index(conn, %{"standard_id" => standard_id}) do
    standard = Config.get_standard!(standard_id)
    survey_templates = Config.list_survey_templates(standard)
    render(conn, "index.html", survey_templates: survey_templates, standard: standard)
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    standard = Config.get_standard!(conn.params["standard_id"]) 
    changeset = Config.build_survey_template(standard)
    render(conn, "new.html", changeset: changeset, standard: standard)
  end

  def create(conn, %{"standard_id" => standard_id, "survey_template" => survey_template_params}) do
    standard = Config.get_standard!(standard_id)
    case Config.create_survey_template(standard, survey_template_params) do
      {:ok, survey_template} ->
        conn
        |> put_flash(:info, "Survey template created successfully.")
        |> redirect(to: Routes.ambit_standard_path(conn, :show, standard.ambit, standard))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, standard: standard)
    end
  end

  def show(conn, %{"standard_id" => standard_id, "id" => id}) do
    standard = Config.get_standard!(standard_id)
    survey_template = Config.get_survey_template!(id)
    render(conn, "show.html", survey_template: survey_template, standard: standard)
  end

  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"standard_id" => standard_id, "id" => id}) do
    standard = Config.get_standard!(standard_id)
    survey_template = Config.get_survey_template!(id)
    changeset = Config.change_survey_template(survey_template)
    render(conn, "edit.html", survey_template: survey_template, changeset: changeset, standard: standard)
  end

  def update(conn, %{"standard_id" => standard_id, "id" => id, "survey_template" => survey_template_params}) do
    standard = Config.get_standard!(standard_id)
    survey_template = Config.get_survey_template!(id)
    case Config.update_survey_template(survey_template, survey_template_params) do
      {:ok, survey_template} ->
        conn
        |> put_flash(:info, "Survey Template updated successfully.")
        |> redirect(to: Routes.ambit_standard_survey_template_path(conn, :show, standard.ambit, standard, survey_template))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", survey_template: survey_template, changeset: changeset, standard: standard)
    end
  end

  def delete(conn, %{"standard_id" => standard_id, "id" => id}) do
    standard = Config.get_standard!(standard_id)
    survey_template = Config.get_survey_template!(id)
    {:ok, _standard} = Config.delete_survey_template(survey_template)

    conn
    |> put_flash(:info, "Survey template deleted successfully.")
    |> redirect(to: Routes.ambit_standard_path(conn, :show, standard.ambit, standard))
  end
end
