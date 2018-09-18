defmodule ElixirHll do
  @moduledoc """
  Documentation for ElixirHll.
  """
  require Logger

  alias ElixirHll.Util

  @bucket_size 1024

  def new(), do: %{}

  def bigger(a, b) when a > b, do: a
  def bigger(_a, b), do: b

  def padd(hll, value) do
    bit = Util.low_zeros(value)
    bucket = rem(Util.simple_hash(value), @bucket_size)
    Map.update(hll, bucket, bit, fn x -> bigger(x, bit) end)
  end

  def size(hll) do
    # 调和平均
    {counts, avgbits} =
      hll
      |> Map.values()
      |> Util.harmonic_average()

    :math.pow(2, avgbits) * counts
  end
end
