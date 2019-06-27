defmodule SustentaWeb.SurveyTemplateControllerTest do
  use SustentaWeb.ConnCase

  alias Sustenta.Config

  @create_attrs %{active: true, name: "some name"}
  @update_attrs %{active: false, name: "some updated name"}
  @invalid_attrs %{active: nil, name: nil}

  def fixture(:survey_template) do
    {:ok, survey_template} = Config.create_survey_template(@create_attrs)
    survey_template
  end

  describe "index" do
    test "lists all config_survey_templates", %{conn: conn} do
      conn = get(conn, Routes.survey_template_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Config survey templates"
    end
  end

  describe "new survey_template" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.survey_template_path(conn, :new))
      assert html_response(conn, 200) =~ "New Survey template"
    end
  end

  describe "create survey_template" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.survey_template_path(conn, :create), survey_template: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.survey_template_path(conn, :show, id)

      conn = get(conn, Routes.survey_template_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Survey template"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.survey_template_path(conn, :create), survey_template: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Survey template"
    end
  end

  describe "edit survey_template" do
    setup [:create_survey_template]

    test "renders form for editing chosen survey_template", %{conn: conn, survey_template: survey_template} do
      conn = get(conn, Routes.survey_template_path(conn, :edit, survey_template))
      assert html_response(conn, 200) =~ "Edit Survey template"
    end
  end

  describe "update survey_template" do
    setup [:create_survey_template]

    test "redirects when data is valid", %{conn: conn, survey_template: survey_template} do
      conn = put(conn, Routes.survey_template_path(conn, :update, survey_template), survey_template: @update_attrs)
      assert redirected_to(conn) == Routes.survey_template_path(conn, :show, survey_template)

      conn = get(conn, Routes.survey_template_path(conn, :show, survey_template))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, survey_template: survey_template} do
      conn = put(conn, Routes.survey_template_path(conn, :update, survey_template), survey_template: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Survey template"
    end
  end

  describe "delete survey_template" do
    setup [:create_survey_template]

    test "deletes chosen survey_template", %{conn: conn, survey_template: survey_template} do
      conn = delete(conn, Routes.survey_template_path(conn, :delete, survey_template))
      assert redirected_to(conn) == Routes.survey_template_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.survey_template_path(conn, :show, survey_template))
      end
    end
  end

  defp create_survey_template(_) do
    survey_template = fixture(:survey_template)
    {:ok, survey_template: survey_template}
  end
end
