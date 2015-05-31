defmodule ExampleError do
  require Monad.Error, as: Error
  import Error

  def my_div(_numerator,0), do: Error.fail("Division by zero is not allowed")
  def my_div(numerator, denominator), do: Error.return(numerator/denominator)

  def my_sum(a,b), do: Error.return(a+b)

  def output(x) do
  	case x do
  	  {:error, reason} -> IO.puts "Error: #{reason}"
      {:ok, value} -> IO.puts value
    end
  end

  def scenario1() do
    val =
    Error.p do
        Error.return(100)
      |> my_sum(50)
      |> my_div(2)
    end
    output(val)
  end

  def scenario2() do
    val =
    Error.p do
        Error.return(0)
      |> my_sum(0)
      |> (&my_div(100, &1)).()
    end
    output(val)
  end
end
