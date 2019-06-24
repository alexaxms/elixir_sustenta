defmodule SustentaWeb.AmbitControllerTest do
  use SustentaWeb.ConnCase

  alias Sustenta.Config

  @create_attrs %{name: "some name", number: 42}
  @update_attrs %{name: "some updated name", number: 43}
  @invalid_attrs %{name: nil, number: nil}

  def fixture(:ambit) do
    {:ok, ambit} = Config.create_ambit(@create_attrs)
    ambit
  end

  describe "index" do
    test "lists all config_ambits", %{conn: conn} do
      conn = get(conn, Routes.ambit_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Config ambits"
    end
  end

  describe "new ambit" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.ambit_path(conn, :new))
      assert html_response(conn, 200) =~ "New Ambit"
    end
  end

  describe "create ambit" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.ambit_path(conn, :create), ambit: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.ambit_path(conn, :show, id)

      conn = get(conn, Routes.ambit_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Ambit"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.ambit_path(conn, :create), ambit: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Ambit"
    end
  end

  describe "edit ambit" do
    setup [:create_ambit]

    test "renders form for editing chosen ambit", %{conn: conn, ambit: ambit} do
      conn = get(conn, Routes.ambit_path(conn, :edit, ambit))
      assert html_response(conn, 200) =~ "Edit Ambit"
    end
  end

  describe "update ambit" do
    setup [:create_ambit]

    test "redirects when data is valid", %{conn: conn, ambit: ambit} do
      conn = put(conn, Routes.ambit_path(conn, :update, ambit), ambit: @update_attrs)
      assert redirected_to(conn) == Routes.ambit_path(conn, :show, ambit)

      conn = get(conn, Routes.ambit_path(conn, :show, ambit))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, ambit: ambit} do
      conn = put(conn, Routes.ambit_path(conn, :update, ambit), ambit: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Ambit"
    end
  end

  describe "delete ambit" do
    setup [:create_ambit]

    test "deletes chosen ambit", %{conn: conn, ambit: ambit} do
      conn = delete(conn, Routes.ambit_path(conn, :delete, ambit))
      assert redirected_to(conn) == Routes.ambit_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.ambit_path(conn, :show, ambit))
      end
    end
  end

  defp create_ambit(_) do
    ambit = fixture(:ambit)
    {:ok, ambit: ambit}
  end
end
