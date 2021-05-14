defmodule Hangman do
  @moduledoc """
  Defines the API of the hangman game backend
  """

  def new() do
    # DynamicSupervisor.start_child(Hangman.DynamicSupervisor, child())
    {:ok, pid} = Hangman.App.start_child()
    pid
  end

  def tally(game_server) do
    GenServer.call(game_server, { :tally, })
  end

  def make_guess(game_server, guess) do
    GenServer.call(game_server, { :make_guess, guess})
  end

end
