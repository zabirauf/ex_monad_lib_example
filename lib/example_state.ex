defmodule ExampleState do
  require Monad.State, as: State
  import State

  # Returns sum and increments state
  def my_sum(a,b) do
    # Use get to read the state and
    # use put to write the state. These
    # functions should be called in State.m block
    State.m do
      x <- get
      put x+1
      return a+b
    end
  end

  # Returns subtraction and increments state
  def my_subtraction(a,b) do
    State.m do
      x <- get
      put x+1
      return a-b
    end
  end

  # Outputs "{8, 2}"
  def scenario1() do
    # Call run to run the state monad
    run(0, State.p do
          return(5)
       |> my_sum(10)
       |> my_subtraction(7)
    end)
  end
end
