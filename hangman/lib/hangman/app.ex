defmodule Hangman.App do

  use Application

  def start(_type, _args) do
    DynamicSupervisor.start_link(options())
  end

  def start_child() do
    DynamicSupervisor.start_child(
      Hangman.DynamicSupervisor,
      child()
      )
  end

  defp child do
      %{
        id: Hangman.GameServer,
        start: {Hangman.GameServer, :start_link, []}
      }
  end

  defp options do
    [
      name: Hangman.DynamicSupervisor,
      strategy: :one_for_one, # starting supervisor doesn't create children
    ]
  end

  #   defp children do
  #   [
  #     {DynamicSupervisor, strategy: :one_for_one, name: Hangman.GameSupervisor}
  #   ]
  # end
  # defp options do
  #   [
  #     name: Hangman.Supervisor,
  #     strategy: :one_for_one, # starting supervisor doesn't create children
  #   ]
  # end
end
