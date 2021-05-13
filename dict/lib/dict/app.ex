defmodule Dict.App do
  use Application
  import Supervisor.Spec

  def start(_type, _args) do
    Supervisor.start_link(children(), options())
  end

  defp children() do
    [
      %{
        id: Dict.WordList,
        start: {Dict.WordList, :start_link, []}
      }
    ]
  end
  defp options() do
    [
      name: Dict.Supervisor,
      strategy: :one_for_one,
    ]
  end

end
