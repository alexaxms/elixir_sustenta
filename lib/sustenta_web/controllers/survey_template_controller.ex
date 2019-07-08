defmodule SustentaWeb.SurveyTemplateController do
  use SustentaWeb, :controller
  alias Sustenta.Config
  

  def index(conn, %{"ambit_id" => ambit_id}) do
    ambit = Config.get_ambit!(ambit_id)
    survey_templates = Config.list_survey_templates(ambit)
    render(conn, "index.html", survey_templates: survey_templates, ambit: ambit)
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    ambit = Config.get_ambit!(conn.params["ambit_id"]) 
    changeset = Config.build_survey_template(ambit)
    render(conn, "new.html", changeset: changeset, ambit: ambit)
  end

  def create(conn, %{"ambit_id" => ambit_id, "survey_template" => survey_template_params}) do
    ambit = Config.get_ambit!(ambit_id)
    case Config.create_survey_template(ambit, survey_template_params) do
      {:ok, survey_template} ->
        conn
        |> put_flash(:info, "Survey template created successfully.")
        |> redirect(to: Routes.ambit_path(conn, :show, ambit))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, ambit: ambit)
    end
  end

  def show(conn, %{"ambit_id" => ambit_id, "id" => id}) do
    ambit = Config.get_ambit!(ambit_id)
    survey_template = Config.get_survey_template!(id)
    render(conn, "show.html", survey_template: survey_template, ambit: ambit)
  end

  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"ambit_id" => ambit_id, "id" => id}) do
    ambit = Config.get_ambit!(ambit_id)
    survey_template = Config.get_survey_template!(id)
    changeset = Config.change_survey_template(survey_template)
    render(conn, "edit.html", survey_template: survey_template, changeset: changeset, ambit: ambit)
  end

  def update(conn, %{"ambit_id" => ambit_id, "id" => id, "survey_template" => survey_template_params}) do
    ambit = Config.get_ambit!(ambit_id)
    survey_template = Config.get_survey_template!(id)
    case Config.update_survey_template(survey_template, survey_template_params) do
      {:ok, survey_template} ->
        conn
        |> put_flash(:info, "Survey Template updated successfully.")
        |> redirect(to: Routes.ambit_survey_template_path(conn, :show, ambit, survey_template))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", survey_template: survey_template, changeset: changeset, ambit: ambit)
    end
  end

  def delete(conn, %{"ambit_id" => ambit_id, "id" => id}) do
    ambit = Config.get_ambit!(ambit_id)
    survey_template = Config.get_survey_template!(id)
    {:ok, _standard} = Config.delete_survey_template(survey_template)

    conn
    |> put_flash(:info, "Survey template deleted successfully.")
    |> redirect(to: Routes.ambit_standard_path(conn, :show, ambit))
  end
end
