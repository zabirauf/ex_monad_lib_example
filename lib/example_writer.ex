defmodule ListWriter do
  use Monad.Writer
  def initial, do: []
  def combine(new, acc), do: acc ++ new
end

defmodule ExampleWriter do
  import ListWriter

  def my_sum(a,b) do
    ListWriter.m do
      tell ["Adding #{a} and #{b}"]
      return a+b
    end
  end

  def my_subtraction(a,b) do
    ListWriter.m do
      tell ["Subtracting #{a} and #{b}"]
      return a-b
    end
  end

  def scenario1() do
    run(ListWriter.p do
         return(5)
      |> my_sum(10)
      |> my_subtraction(7)
    end)
  end
end
