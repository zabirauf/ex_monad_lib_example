defmodule ExampleMaybe do
  require Monad.Maybe, as: Maybe
  import Maybe

  # The division operator which return something if successfull
  # otherwise in case of failure returns nothing
  def my_div(_numerator,0) do
  	# Returns nothing
  	Maybe.fail(nil)
  end

  def my_div(numerator, denominator) do
    # Returns {:something, result}
    Maybe.return(numerator/denominator)
  end

  # Sum always returns something
  def my_sum(a,b) do
    # Returns {:just, result}
    Maybe.return(a+b)
  end

  def output(x) do
  	case is_nothing(x) do
  	  true -> IO.puts "No value gotten"
      false -> x |> from_just |> IO.puts
    end
  end

  # A successful scenario
  def scenario1() do
    # The |> opeartor in Maybe.p acts as bind
    val =
    Maybe.p do
        Maybe.return(100)
      |> my_sum(50)
      |> my_div(2)
    end
    output(val) # Outputs "75.0"
  end

  # A scenario where division by zero is done
  def scenario2() do
    val =
    Maybe.p do
        Maybe.return(0)
      |> my_sum(0)
      |> (&my_div(100, &1)).()
    end
    output(val) # Outputs "No value gotten"
  end
end
