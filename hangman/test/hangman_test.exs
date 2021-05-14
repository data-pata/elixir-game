defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "initializes new game process" do
    pid = Hangman.new()
    assert is_pid(pid)
    # assert game.turns_left === 7
    # assert length(game.word) > 0

  end
end
