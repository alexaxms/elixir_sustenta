defmodule Sustenta.Survey.Survey do
    use GenServer
    alias Sustenta.Repo
    alias Sustenta.Survey.{Answer, Question}
    import Ecto.Query, only: [from: 2]
  
    def start_link(opts \\ []) do
      GenServer.start_link(__MODULE__, [], opts)
    end
  
    def new_question(question_params) do
      GenServer.call(:survey, {:new_question, question_params})
    end
  
    def init([]) do
      questions = Repo.all from q in Question, 
                join: a in assoc(q, :answers),
                select: %{id: q.id, question: q.question, type: q.type}  
      {:ok, questions}
    end
  
    def handle_call({:new_question, question_params}, _from, questions) do
      changeset = Question.changeset(%Question{}, question_params)
      case Repo.insert(changeset) do
        {:ok, question} ->
          {:reply, {:ok, question}, [question | questions]}
        {:error, changeset} ->
          {:reply, {:error, changeset}, questions}
      end
    end
  
  end