defmodule Hangman.Game do

  defstruct(
    state: :init,
    turns_left: 7,
    word: [],
    guessed: MapSet.new(),
  )

  def new_game() do
    %Hangman.Game{
      word: Dicti.rand_word() |> String.codepoints()
    }
  end

  def make_move(game = %{state: state}, _guess) when state in [:won,:lost] do
    {game, tally(game)}
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.guessed, guess))
    {game, tally(game)}
  end

  def accept_move(game, _guess, _guessed = true) do
    Map.put(game, :state, :already_guessed)
  end
  def accept_move(game, guess, _guessed) do
    Map.put(game, :guessed, MapSet.put(game.guessed, guess))
  end

  def tally(_game) do
    123
  end
end
