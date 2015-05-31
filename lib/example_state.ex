defmodule ExampleState do
  require Monad.State, as: State
  import State

  def my_sum(a,b) do
    State.m do
      x <- get
      put x+1
      return a+b
    end
  end

  def my_subtraction(a,b) do
    State.m do
      x <- get
      put x+1
      return a-b
    end
  end

  # {8, 2}
  def scenario1() do
    run(0, State.p do
          return(5)
       |> my_sum(10)
       |> my_subtraction(7)
    end)
  end
end
