defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "initializes new game state struct" do
    game = Hangman.new()
    assert game.state === :init
    assert game.turns_left === 7
    assert length(game.word) > 0
    
  end
end
