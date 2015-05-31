defmodule ExampleMaybe do
  require Monad.Maybe, as: Maybe
  import Maybe

  def my_div(_numerator,0), do: Maybe.fail(nil)
  def my_div(numerator, denominator), do: Maybe.return(numerator/denominator)

  def my_sum(a,b), do: Maybe.return(a+b)

  def output(x) do
  	case is_nothing(x) do
  	  true -> IO.puts "No value gotten"
      false -> x |> from_just |> IO.puts
    end
  end

  def scenario1() do
    val =
    Maybe.p do
        Maybe.return(100)
      |> my_sum(50)
      |> my_div(2)
    end
    output(val)
  end

  def scenario2() do
    val =
    Maybe.p do
        Maybe.return(0)
      |> my_sum(0)
      |> (&my_div(100, &1)).()
    end
    output(val)
  end
end
