defmodule TextClient.Prompter do

  def user_input(game_state) do
    IO.gets("Your Guess: ")
    |> valid?(game_state)
    # |> IO.inspect
  end

  defp valid?({:error, reason}, _) do
    IO.puts "Game Over. #{reason}"
    exit :normal
  end

  defp valid?(:eof, _) do
    IO.puts "ok, off and play WoW instead..."
    exit :normal
  end

  defp valid?(input, game_state) do
    input = String.trim(input) |> String.downcase()
    cond do
      input =~ ~r/\A[a-z]\z/ ->
        %{game_state | guessed_letter: input}
      true ->
        IO.puts "Guess a letter from a to z"
        user_input(game_state)
    end
  end
end
