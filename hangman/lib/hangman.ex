defmodule Hangman do
  @moduledoc """
  Defines the API of the hangman game backend
  """

  # Game logic module
  alias Hangman.Game, as: Game

  def hello do
    IO.puts Dicti.rand_word()
  end

  @doc """
    creates and returns a new game state
  """
  defdelegate new(), to: Game, as: :new_game

  def move(state, mov) do
    
  end

end
