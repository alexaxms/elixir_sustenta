defmodule SustentaWeb.AnswerController do
  use SustentaWeb, :controller
  alias Sustenta.Survey
  alias Sustenta.Survey.Answer

  def index(conn, %{"question_id" => question_id}) do
    survey_answers = Survey.list_survey_answers(question_id)
    render(conn, "index.html", survey_answers: survey_answers)
  end

  def new(conn, _params) do
    changeset = Survey.change_answer(%Answer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"answer" => answer_params}) do
    case Survey.create_answer(answer_params) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer created successfully.")
        |> redirect(to: Routes.answer_path(conn, :show, answer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    answer = Survey.get_answer!(id)
    render(conn, "show.html", answer: answer)
  end

  def edit(conn, %{"id" => id}) do
    answer = Survey.get_answer!(id)
    changeset = Survey.change_answer(answer)
    render(conn, "edit.html", answer: answer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "answer" => answer_params}) do
    answer = Survey.get_answer!(id)

    case Survey.update_answer(answer, answer_params) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer updated successfully.")
        |> redirect(to: Routes.answer_path(conn, :show, answer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", answer: answer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    answer = Survey.get_answer!(id)
    {:ok, _answer} = Survey.delete_answer(answer)

    conn
    |> put_flash(:info, "Answer deleted successfully.")
    |> redirect(to: Routes.answer_path(conn, :index))
  end
end
