defmodule Bank.Schema do
  @moduledoc """
    Base database schema for tables that use UUID as primary key.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id

      defimpl Jason.Encoder, for: __MODULE__ do
        def encode(value, opts) do
          value
          |> Map.drop([:__meta__, :__struct__, :inserted_at, :updated_at])
          |> Jason.Encode.map(opts)
        end
      end
    end
  end
end
