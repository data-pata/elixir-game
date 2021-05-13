defmodule Hangman do
  @moduledoc """
  Defines the API of the hangman game backend
  """

  # Game logic module
  alias Hangman.Game, as: Game

  @doc """
  returns a new game state
  """
  defdelegate new(), to: Game, as: :new_game
  defdelegate tally(game), to: Game

  @doc """
  makes a move/guess
  """
  def make_guess(game_state, guess) do
    game_state = Game.make_guess(game_state, guess)
    {game_state, tally(game_state)}
  end

end
