defmodule DictTest do
  use ExUnit.Case
  doctest Dict

  test "greets the world" do
    assert Dict.hello() == :world
  end
end
