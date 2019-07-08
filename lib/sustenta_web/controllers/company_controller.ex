defmodule SustentaWeb.CompanyController do
  use SustentaWeb, :controller

  alias Sustenta.Users
  alias Sustenta.Users.Company

  def new(conn, _params) do
    changeset = Users.change_company(%Company{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    current_user = conn.assigns.current_user
    case Users.create_company(current_user, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: Routes.company_path(conn, :show))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{}) do
    current_user = conn.assigns.current_user
    company = Users.get_company!(current_user)
    render(conn, "show.html", company: company)
  end

  def edit(conn, %{}) do
    current_user = conn.assigns.current_user
    company = Users.get_company!(current_user)
    changeset = Users.change_company(company)
    render(conn, "edit.html", company: company, changeset: changeset)
  end

  def update(conn, %{"company" => company_params}) do
    current_user = conn.assigns.current_user
    company = Users.get_company!(current_user)

    case Users.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: Routes.company_path(conn, :show))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset)
    end
  end

  def delete(conn, %{}) do
    current_user = conn.assigns.current_user
    company = Users.get_company!(current_user)
    {:ok, _company} = Users.delete_company(company)

    conn
    |> put_flash(:info, "Company deleted successfully.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
