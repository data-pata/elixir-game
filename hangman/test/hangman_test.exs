defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "greets the world" do
    assert is_binary(Hangman.hello())
  end

  test "initializes new game states" do
    assert Hangman.new() == %Hangman.Game{
      game_state: :init,
      turns_left: 7,
      word: [],
    }
  end
end
