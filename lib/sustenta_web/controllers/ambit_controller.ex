defmodule SustentaWeb.AmbitController do
  use SustentaWeb, :controller

  alias Sustenta.Config
  alias Sustenta.Config.Ambit

  def index(conn, _params) do
    config_ambits = Config.list_config_ambits()
    render(conn, "index.html", config_ambits: config_ambits)
  end

  def new(conn, _params) do
    changeset = Config.change_ambit(%Ambit{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ambit" => ambit_params}) do
    case Config.create_ambit(ambit_params) do
      {:ok, ambit} ->
        conn
        |> put_flash(:info, "Ambit created successfully.")
        |> redirect(to: Routes.ambit_path(conn, :show, ambit))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ambit = Config.get_ambit_with_children!(id)
    render(conn, "show.html", ambit: ambit)
  end

  def edit(conn, %{"id" => id}) do
    ambit = Config.get_ambit!(id)
    changeset = Config.change_ambit(ambit)
    render(conn, "edit.html", ambit: ambit, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ambit" => ambit_params}) do
    ambit = Config.get_ambit!(id)

    case Config.update_ambit(ambit, ambit_params) do
      {:ok, ambit} ->
        conn
        |> put_flash(:info, "Ambit updated successfully.")
        |> redirect(to: Routes.ambit_path(conn, :show, ambit))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ambit: ambit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ambit = Config.get_ambit!(id)
    {:ok, _ambit} = Config.delete_ambit(ambit)

    conn
    |> put_flash(:info, "Ambit deleted successfully.")
    |> redirect(to: Routes.ambit_path(conn, :index))
  end
end
