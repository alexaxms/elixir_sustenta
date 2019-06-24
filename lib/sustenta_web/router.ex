defmodule SustentaWeb.Router do
  use SustentaWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end
  
  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", SustentaWeb do
    pipe_through [:browser, :protected]
    scope "/config" do
      resources "/ambits", AmbitController do
        resources "/standards", StandardController
      end  
    end
    resources "/survey_questions", QuestionController do
      resources "/survey_answers", AnswerController
    end
  end

  scope "/", SustentaWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SustentaWeb do
  #   pipe_through :api
  # end
end
