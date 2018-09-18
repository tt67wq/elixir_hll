defmodule ElixirHll.Util do
  use Bitwise

  @doc """
  Binary exponentiation to support large integers which :math.pow can't since
  it returns floats

  ## Examples
      iex> Bitmap.Utils.pow(2, 10)
      1024
      iex> Bitmap.Utils.pow(2, 9)
      512
  """
  def pow(x, n) when is_integer(x) and is_integer(n) and n >= 0, do: pow(x, n, 1)

  defp pow(_x, 0, acc), do: acc
  defp pow(x, 1, acc), do: x * acc
  defp pow(x, n, acc) when rem(n, 2) == 0, do: pow(x * x, div(n, 2), acc)
  defp pow(x, n, acc) when rem(n, 2) == 1, do: pow(x * x, div(n - 1, 2), acc * x)

  def low_zeros(0), do: 0
  def low_zeros(value), do: lz(value, 1) - 1

  defp lz(value, index) do
    cond do
      value >>> index <<< index == value -> lz(value, index + 1)
      :else -> index
    end
  end

  def simple_hash(value) do
    (value &&& 0xFFF0000) >>> 16
  end

  def harmonic_average(values), do: ha(values, 0, 0)
  defp ha([], count, acc), do: {count, count / acc}
  defp ha([0 | t], count, acc), do: ha(t, count, acc)
  defp ha([h | t], count, acc), do: ha(t, count + 1, acc + 1 / h)
end
