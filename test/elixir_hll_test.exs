defmodule ElixirHllTest do
  use ExUnit.Case
  use Bitwise
  doctest ElixirHll

  test "test padd" do
    hll = ElixirHll.new()
    limit = 1 <<< 32
    elems = 1000000

    size =
      1..elems
      |> Enum.map(fn _ -> 1..limit |> Enum.random() end)
      |> Enum.reduce(hll, fn x, acc -> ElixirHll.padd(acc, x) end)
      |> ElixirHll.size()

    IO.puts("size => #{size}")
    IO.puts("error rate => #{abs(size - elems) / elems * 100}%")
  end
end
