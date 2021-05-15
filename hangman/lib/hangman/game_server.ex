defmodule Hangman.GameServer do
  alias Hangman.Game
  use GenServer

  @mod __MODULE__

  @spec start_link :: :ignore | {:error, any} | {:ok, pid}
  def start_link() do
    IO.inspect(self())
    GenServer.start_link(@mod, nil)
  end

  # new game state linked to this genserver instance
  def init(_) do
    {:ok, Game.new_game() }
  end

  # make_guess
  def handle_call( {:make_guess, guess}, _from, game_state) do
    {game_state, tally} = Game.make_guess(game_state, guess)
    { :reply, tally, game_state}
  end

  # get tally from game state
  def handle_call( {:tally}, _from, game_state) do
    { :reply, Game.tally(game_state), game_state }
  end

end
