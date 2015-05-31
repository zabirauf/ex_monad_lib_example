defmodule ExampleError do
  require Monad.Error, as: Error
  import Error

  # The division operator which return ok and result if successfull
  # otherwise in case of failure returns error with reason
  def my_div(_numerator,0) do
    # Returns {:error, reason}
    Error.fail("Division by zero is not allowed")
  end
  def my_div(numerator, denominator) do
    # Returns {:ok, result}
    Error.return(numerator/denominator)
  end

  def my_sum(a,b) do
    # Sum always returns {:ok, result}
    Error.return(a+b)
  end

  def output(x) do
  	case x do
  	  {:error, reason} -> IO.puts "Error: #{reason}"
      {:ok, value} -> IO.puts value
    end
  end

  # Successful scenario
  def scenario1() do
    # Here the |> opeartor in Error.p acts as bind operator
    val =
    Error.p do
        Error.return(100)
      |> my_sum(50)
      |> my_div(2)
    end
    output(val) # Outputs "75.0"
  end

  # Scenario where division fails due to division by zero
  def scenario2() do
    val =
    Error.p do
        Error.return(0)
      |> my_sum(0)
      |> (&my_div(100, &1)).()
    end
    output(val) # Outputs "Error: Division by zero is not allowed"
  end
end
