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
      assert {^game, _} = Game.make_guess(game, "x")
    end
  end

  test "doesn't accept already guessed letters" do
    game = Game.new_game()
    {game, _} = Game.make_guess(game, "a")
    assert game.state != :already_guessed
    {game, _} = Game.make_guess(game, "a")
    assert game.state == :already_guessed
  end

  test "score guess when correct" do
    game = Game.new_game()
    # [letter | _] = game.word
    game = Game.score_guess(game, true )
    assert game.state === :good_guess
  end

  # test "score guess when incorrect guess" do
  #   game = Game.new_game()
  #   game = Game.score_guess(game, false )
  #   assert game.state === :good_guess
  # end

  test "good guess move" do
    game = Game.new_game()
    {game, _} = Game.make_guess(game, hd(game.word))
    assert game.state === :good_guess
    assert game.turns_left === 7
  end

  test "good guess wins game" do
    game = Game.new_game("abc",7)
    {game, _} = Game.make_guess(game, "a")
    assert game.state === :good_guess
    {game, _} = Game.make_guess(game, "b")
    assert game.state === :good_guess
    {game, _} = Game.make_guess(game, "c")
    assert game.state === :won
  end

  test "bad guess move" do
    game = Game.new_game("wyoming", 3)
    {game, _} = Game.make_guess(game, "a")
    assert game.state === :bad_guess
    assert game.turns_left === 2

    {game, _} = Game.make_guess(game, "b")
    assert game.state === :bad_guess
    assert game.turns_left === 1

    {game, _} = Game.make_guess(game, "c")
    assert game.state === :lost
    assert game.turns_left === 0
  end

  test "tally reveals guesses only" do
    game = Game.new_game("wyoming", 3)
    {game, _} = Game.make_guess(game, "w")
    {game, _} = Game.make_guess(game, "y")
    Game.reveal_guessed(game.word, game.guessed)
    |> IO.puts
  end

end
