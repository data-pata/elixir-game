defmodule TextClient.Player do
  alias TextClient.{Prompter, State, Summary }

  # indirectly recursive gameplay
  def play(s = %State{tally: %{state: :won}}) do
    IO.puts(Enum.join(s.tally.letters, " "))
    msg_exit("Congratulations, you won!")
  end
  def play(%State{tally: %{state: :lost}}) do
    msg_exit("Game Over.")
  end
  def play(game_state = %State{tally: %{state: :good_guess}}) do
     msg_cont(game_state, "Good on you. Correct guess.")
  end
  def play(game_state = %State{tally: %{state: :bad_guess}}) do
     msg_cont(game_state, "Nope.")
  end
  def play(game_state = %State{tally: %{state: :already_guessed}}) do
     msg_cont(game_state, "Stop repeating yourself.")
  end
  def play(game_state = %State{tally: %{state: :init}}) do
     msg_cont(game_state, "Time to play.")
  end
  def play(game) do
    continue(game)
  end

  defp continue(game_state) do
    game_state
    |> Summary.display
    |> Prompter.user_input
    |> action()
    |> play()
  end

  defp action(state) do
    tally = Hangman.make_guess(state.game_service, state.guessed_letter)
    %State{state | tally: tally}
    # |> IO.inspect()
  end

  defp msg_cont(game_state, msg) do
    IO.puts msg
    continue(game_state)
  end

  defp msg_exit(msg) do
    IO.puts msg
    exit(:normal)
  end
end
