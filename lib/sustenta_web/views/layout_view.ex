defmodule SustentaWeb.LayoutView do
  use SustentaWeb, :view
  alias Sustenta.Config

  def ambits do
    Config.list_config_ambits
  end
end
