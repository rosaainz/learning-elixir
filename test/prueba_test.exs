defmodule PruebaTest do
  use ExUnit.Case
  doctest Prueba

  test "greets the world" do
    assert Prueba.hello() == :world
  end
end
