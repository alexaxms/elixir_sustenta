defmodule SustentaWeb.AnswerController do
  use SustentaWeb, :controller
  alias Sustenta.Survey
  

  def index(conn, %{"question_id" => question_id}) do
    question = Survey.get_question!(question_id)
    survey_answers = Survey.list_survey_answers(question)
    render(conn, "index.html", survey_answers: survey_answers, question: question)
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    question = Survey.get_question!(conn.params["question_id"])
    changeset = Survey.build_answer(question)
    render(conn, "new.html", changeset: changeset, question: question)
  end

  def create(conn, %{"question_id" => question_id, "answer" => answer_params}) do
    question = Survey.get_question!(question_id)
    case Survey.create_answer(question, answer_params) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer created successfully.")
        |> redirect(to: Routes.question_answer_path(conn, :show, question, answer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"question_id" => question_id, "id" => id}) do
    question = Survey.get_question!(question_id)
    answer = Survey.get_answer!(id)
    render(conn, "show.html", answer: answer, question: question)
  end

  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"question_id" => question_id, "id" => id}) do
    question = Survey.get_question!(question_id)
    answer = Survey.get_answer!(id)
    changeset = Survey.change_answer(answer)
    render(conn, "edit.html", answer: answer, changeset: changeset, question: question)
  end

  def update(conn, %{"question_id" => question_id, "id" => id, "answer" => answer_params}) do
    question = Survey.get_question!(question_id)
    answer = Survey.get_answer!(id)
    case Survey.update_answer(answer, answer_params) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer updated successfully.")
        |> redirect(to: Routes.question_answer_path(conn, :show, question, answer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", answer: answer, changeset: changeset)
    end
  end

  def delete(conn, %{"question_id" => question_id, "id" => id}) do
    question = Survey.get_question!(question_id)
    answer = Survey.get_answer!(id)
    {:ok, _answer} = Survey.delete_answer(answer)

    conn
    |> put_flash(:info, "Answer deleted successfully.")
    |> redirect(to: Routes.question_answer_path(conn, :index, question))
  end
end
