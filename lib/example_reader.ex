defmodule ExampleReader do
  require Monad.Reader, as: Reader
  import Reader

  # We create a greeting string by getting name as argument
  # and getting greeting from the reader monad
  def greeting(name) do
    # The value for the reader can be read in Reader.m block
    Reader.m do
      # Getting the greeting by calling ask function
      greeting <- ask
      return "#{greeting}, #{name}"
    end
  end

  # If the greeting is hello it puts exclamation mark
  # otherwise adds . at end of string
  def done(input) do
    Reader.m do
      greeting <- ask
      case (greeting == "Hello") do
        true -> return "#{input} !!!"
        false -> return "#{input}."
      end
    end
  end

  # Adds a new line to whatever string it gets
  def add_newline(input) do
    return("#{input}\n")
  end

  # Outputs "Hello, Zohaib !!!\n"
  def scenario1() do
    # You use the run function to call put the value and
    # execute the functions with that value in context.
    #
    # You compose the functions by using |> operator
    # which acts as bind operator in Reader.p block
    run("Hello",
    Reader.p do
         return("Zohaib")
      |> greeting
      |> done
      |> add_newline
    end)
  end

  # Outputs "Welcome, Zohaib.\n"
  def scenario2() do
    run("Welcome",
    Reader.p do
         return("Zohaib")
      |> greeting
      |> done
      |> add_newline
    end)
  end
end
