defmodule ListWriter do
  use Monad.Writer
  # Called when the writer monad is started
  # to initialize
  def initial do
    []
  end

  # Called whenever you put new value to the writer
  def combine(new, acc) do
    acc ++ new
  end
end

defmodule ExampleWriter do
  import ListWriter

  # We return the sum and write logs to the writer
  def my_sum(a,b) do
    # If you want to write then you have to
    # call tell in your created writers m block,
    # As we defined ListWriter so in this
    # case its ListWriter.m
    ListWriter.m do
      tell ["Adding #{a} and #{b}"]
      return a+b
    end
  end
  # We return the subtraction and write logs to the writer
  def my_subtraction(a,b) do
    ListWriter.m do
      tell ["Subtracting #{a} and #{b}"]
      return a-b
    end
  end

  # Outputs "{8, ["Adding 5 and 10", "Subtracting 15 and 7"]}"
  def scenario1() do
    # We run the writer monad by calling run
    # and pass in the function or composition of function
    #
    # The |> operators becomes bind in p block of your
    # writer. As we defined ListWriter so its ListWriter.p
    # block here
    run(ListWriter.p do
         return(5)
      |> my_sum(10)
      |> my_subtraction(7)
    end)
  end
end
