defmodule TextClient.Interaction do
  alias TextClient.{State, Player}

  def start() do
    Hangman.new()
    |> setup_state()
    # |> IO.inspect()
    |> Player.play()
  end

  def setup_state(state) do
    %State{
      game_service: state,
      tally: Hangman.tally(state)
    }
  end

  # infinite loop game play state machine
  def play(state) do

  end

end
