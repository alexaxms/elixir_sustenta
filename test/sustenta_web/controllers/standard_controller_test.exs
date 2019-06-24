defmodule SustentaWeb.StandardControllerTest do
  use SustentaWeb.ConnCase

  alias Sustenta.Config

  @create_attrs %{name: "some name", number: 42}
  @update_attrs %{name: "some updated name", number: 43}
  @invalid_attrs %{name: nil, number: nil}

  def fixture(:standard) do
    {:ok, standard} = Config.create_standard(@create_attrs)
    standard
  end

  describe "index" do
    test "lists all config_standards", %{conn: conn} do
      conn = get(conn, Routes.standard_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Config standards"
    end
  end

  describe "new standard" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.standard_path(conn, :new))
      assert html_response(conn, 200) =~ "New Standard"
    end
  end

  describe "create standard" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.standard_path(conn, :create), standard: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.standard_path(conn, :show, id)

      conn = get(conn, Routes.standard_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Standard"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.standard_path(conn, :create), standard: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Standard"
    end
  end

  describe "edit standard" do
    setup [:create_standard]

    test "renders form for editing chosen standard", %{conn: conn, standard: standard} do
      conn = get(conn, Routes.standard_path(conn, :edit, standard))
      assert html_response(conn, 200) =~ "Edit Standard"
    end
  end

  describe "update standard" do
    setup [:create_standard]

    test "redirects when data is valid", %{conn: conn, standard: standard} do
      conn = put(conn, Routes.standard_path(conn, :update, standard), standard: @update_attrs)
      assert redirected_to(conn) == Routes.standard_path(conn, :show, standard)

      conn = get(conn, Routes.standard_path(conn, :show, standard))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, standard: standard} do
      conn = put(conn, Routes.standard_path(conn, :update, standard), standard: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Standard"
    end
  end

  describe "delete standard" do
    setup [:create_standard]

    test "deletes chosen standard", %{conn: conn, standard: standard} do
      conn = delete(conn, Routes.standard_path(conn, :delete, standard))
      assert redirected_to(conn) == Routes.standard_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.standard_path(conn, :show, standard))
      end
    end
  end

  defp create_standard(_) do
    standard = fixture(:standard)
    {:ok, standard: standard}
  end
end
