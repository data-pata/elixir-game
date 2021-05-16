defmodule TextClient.Interaction do

  @game_server :hangman@saison

  alias TextClient.{State, Player}

  def start() do
    IO.inspect(self())
    new_game()
    |> setup_state()
    |> Player.play()
  end

  def setup_state(state) do
    %State{
      game_service: state,
      tally: Hangman.tally(state)
    }
  end

  defp new_game() do
    Node.connect(@game_server)
    :rpc.call(@game_server, Hangman, :new, [])
  end

end
