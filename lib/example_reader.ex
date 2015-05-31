defmodule ExampleReader do
  require Monad.Reader, as: Reader
  import Reader

  def greeting(name) do
    Reader.m do
      greeting <- ask
      return "#{greeting}, #{name}"
    end
  end

  def done(input) do
    Reader.m do
      greeting <- ask
      case (greeting == "Hello") do
        true -> return "#{input} !!!"
        false -> return "#{input}."
      end
    end
  end

  def add_newline(input), do: return("#{input}\n")

  def scenario1() do
    run("Hello",
    Reader.p do
         return("Zohaib")
      |> greeting
      |> done
      |> add_newline
    end)
  end

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
