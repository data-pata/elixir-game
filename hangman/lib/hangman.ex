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
  returns a new game state
  """
  defdelegate new(), to: Game, as: :new_game
  @doc """
  makes a move/guess
  """
  defdelegate move(state, move), to: Game, as: :make_move
    
end
