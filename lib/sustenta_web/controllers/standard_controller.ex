defmodule SustentaWeb.StandardController do
  use SustentaWeb, :controller
  alias Sustenta.Config
  

  def index(conn, %{"ambit_id" => ambit_id}) do
    ambit = Config.get_ambit!(ambit_id)
    standards = Config.list_standards(ambit)
    render(conn, "index.html", standards: standards, ambit: ambit)
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    ambit = Config.get_ambit!(conn.params["ambit_id"])
    changeset = Config.build_standard(ambit)
    render(conn, "new.html", changeset: changeset, ambit: ambit)
  end

  def create(conn, %{"ambit_id" => ambit_id, "standard" => standard_params}) do
    ambit = Config.get_ambit!(ambit_id)
    case Config.create_standard(ambit, standard_params) do
      {:ok, standard} ->
        conn
        |> put_flash(:info, "Standard created successfully.")
        |> redirect(to: Routes.ambit_standard_path(conn, :show, ambit, standard))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"ambit_id" => ambit_id, "id" => id}) do
    ambit = Config.get_ambit!(ambit_id)
    standard = Config.get_standard!(id)
    render(conn, "show.html", standard: standard, ambit: ambit)
  end

  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"ambit_id" => ambit_id, "id" => id}) do
    ambit = Config.get_ambit!(ambit_id)
    standard = Config.get_standard!(id)
    changeset = Config.change_standard(standard)
    render(conn, "edit.html", standard: standard, changeset: changeset, ambit: ambit)
  end

  def update(conn, %{"ambit_id" => ambit_id, "id" => id, "standard" => standard_params}) do
    ambit = Config.get_ambit!(ambit_id)
    standard = Config.get_standard!(id)
    case Config.update_standard(standard, standard_params) do
      {:ok, standard} ->
        conn
        |> put_flash(:info, "Standard updated successfully.")
        |> redirect(to: Routes.ambit_standard_path(conn, :show, ambit, standard))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", standard: standard, changeset: changeset)
    end
  end

  def delete(conn, %{"ambit_id" => ambit_id, "id" => id}) do
    ambit = Config.get_ambit!(ambit_id)
    standard = Config.get_standard!(id)
    {:ok, _standard} = Config.delete_standard(standard)

    conn
    |> put_flash(:info, "Standard deleted successfully.")
    |> redirect(to: Routes.ambit_standard_path(conn, :index, ambit))
  end
end
