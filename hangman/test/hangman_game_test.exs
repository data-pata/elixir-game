defmodule HangmanGameTest do
  use ExUnit.Case
  doctest Hangman.Game

  alias Hangman.Game

  test "initializes correct new game state struct" do
    game = Game.new_game()
    assert length(game.word) > 0

    mtch = &String.match?(&1, ~r/^[[:lower:]]+$/)
    assert game.word |> Enum.all?(mtch)
    # assert ["~","ä","ö"] |> Enum.all?(mtch) # false
  end

  test ":state remains the same for :won and :lost" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:state, state)
      assert {^game,  _} = Game.make_move(game, "x")
    end
  end

  test "doesn't accept already guessed letters" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "a")
    assert game.state != :already_guessed
    {game, _tally} = Game.make_move(game, "a")
    assert game.state == :already_guessed
  end

end
