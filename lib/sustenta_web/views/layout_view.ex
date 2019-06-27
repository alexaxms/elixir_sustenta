defmodule SustentaWeb.LayoutView do
  use SustentaWeb, :view
  alias Sustenta.Config

  def ambits do
    Config.list_ambits_with_standards
  end
end
