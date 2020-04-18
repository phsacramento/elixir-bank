defmodule BankWeb.Helpers.ParametersTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias BankWeb.Helpers.Parameters

  describe "filter/2" do
    test "filter params" do
      params = %{
        "name" => "some name",
        "description" => "some description",
        "admin" => "some private rule"
      }

      expected = %{
        "name" => "some name",
        "description" => "some description"
      }

      assert Parameters.filter(params, required: ["name", "description"]) == expected
    end

    test "missing required fields" do
      params = %{
        "name" => "some name",
        "description" => "some description",
        "admin" => "some private rule"
      }

      filters = [required: ["full_name", "description"]]

      expected = {:error, :params_missing, ["full_name"]}

      assert Parameters.filter(params, filters) == expected
    end

    test "return just required and optional fields" do
      params = %{
        "name" => "some name",
        "email" => "paulo@mail.com",
        "phone" => "1199999999",
        "description" => "some description",
        "admin" => "some private rule"
      }

      required = ["name", "email"]
      optional = ["description"]

      expected = %{
        "name" => "some name",
        "email" => "paulo@mail.com",
        "description" => "some description"
      }

      assert Parameters.filter(params, required: required, optional: optional) == expected
    end
  end

  describe "atomize_keys/1" do
    test "atomize all keys" do
      params = %{"key" => [%{"key" => "value"}]}

      assert Parameters.atomize_keys(params) == %{key: [%{key: "value"}]}
    end
  end
end
