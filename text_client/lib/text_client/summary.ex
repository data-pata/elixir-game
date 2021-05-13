defmodule TextClient.Summary do

  def display(game_state = %{ tally: tally}) do
    IO.puts [
      "\n",
      "Progress: #{Enum.join(tally.letters, " ")} \n",
      "Guessed letters: #{Enum.join(tally.guesses, " ")}\n",
      "Guesses left: #{tally.turns_left}\n",
    ]
    game_state
  end
end
