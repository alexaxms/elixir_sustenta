defmodule SustentaWeb.LayoutView do
  use SustentaWeb, :view
  alias Sustenta.{Config, Users}

  def ambits do
    Config.list_ambits_with_standards
  end

  def company(user) do
    Users.get_company!(user)
  end
end
