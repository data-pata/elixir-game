defmodule Hangman.GameServer do
  alias Hangman.Game
  use GenServer

  @mod __MODULE__

  def start_link() do
    GenServer.start_link(@mod, nil )
  end

  # callbacks called by process run by genserver?
  # return new state, note: does not go via Hangman API
  def init(_) do
    {:ok, Game.new_game() }
  end
  # callback from GenServer.call(pid, term())
  def handle_call( {:make_guess, guess}, _from, game_state) do
    {game_state, tally} = Game.make_guess(game_state, guess)
    { :reply, tally, game_state}
  end
end
