defmodule Hangman.Game do

  # export private funcs to test env
  @compile if Mix.env == :test, do: :export_all

  @moduledoc """
  Back End / Game Logic / Implementation module
  """
  
  defstruct(
    state: :init,
    turns_left: 7,
    word: [],
    guessed: MapSet.new()
  )

  @doc """
  Initializes new game state
  takes a string word and a number turns
  returns a game state struct
  """
  def new_game() do
    new_game(Dict.rand_word(), 7)
  end

  def new_game(word, turns) do
    %Hangman.Game{
      word: word |> String.codepoints(),
      turns_left: turns
    }
  end

  def make_guess(game = %{state: state}, _guess)
    when state in [:won,:lost] do
    {game, tally(game)}
  end
  def make_guess(game, guess) do
    game = accept_guess(game, guess, MapSet.member?(game.guessed, guess))
    {game, tally(game)}
  end

  def tally(game) do
    %{
      state: game.state,
      turns_left: game.turns_left,
      letters: game.word |> reveal_guessed(game.guessed),
      guesses: game.guessed |> MapSet.to_list() |> Enum.sort()
    }
  end

  #######################################################

  defp accept_guess(game, _guess, _guessed = true) do
    Map.put(game, :state, :already_guessed)
  end
  defp accept_guess(game, guess, _guessed) do
    Map.put(game, :guessed, MapSet.put(game.guessed, guess))
    |> score_guess(Enum.member?(game.word, guess))
  end

  defp score_guess(game, _correct_guess = true) do
    new_state = MapSet.new(game.word)
    |> MapSet.subset?(game.guessed) # see if sought after word is a true subset of guessed word
    |> won?()
    Map.put(game, :state, new_state)
  end

  defp score_guess(game, _incorrect_guess) do
    game = Map.update!(game, :turns_left, &(&1-1)) # decrement turns left
    new_state = lost?(game.turns_left == 0)
    Map.put(game, :state, new_state)
  end

  defp won?(true), do: :won
  defp won?(_), do: :good_guess
  defp lost?(true), do: :lost
  defp lost?(_), do: :bad_guess

  defp reveal_guessed(letters, guessed_word) do
    letters
    |> Enum.map( fn x -> reveal_letter(x, MapSet.member?(guessed_word, x)) end)
  end
  defp reveal_letter(letter, true), do: letter
  defp reveal_letter(_letter, _), do: "_"

end
