defmodule BankWeb.Helpers.ControllerTest do
  @moduledoc false

  use BankWeb.ConnCase, async: true

  alias Bank.Account
  alias Bank.BankAccount.Changeset
  alias BankWeb.Helpers.Controller, as: ControllerHelper

  describe "parse_response/2" do
    test "return sucess parse" do
      assert ControllerHelper.parse_response({:ok, []}, :created) == {:created, []}
    end

    test "return sucess parse whitout satus input" do
      assert ControllerHelper.parse_response({:ok, []}) == {:ok, []}
    end

    test "clear ecto meta data from response" do
      attrs = %{cpf: "853.479.740-44"}
      account = Changeset.build(%Account{}, attrs)

      assert {:created, parsed_account} =
               ControllerHelper.parse_response({:ok, account}, :created)

      refute Map.has_key?(parsed_account, :__meta__)

      assert {:ok, parsed_account} = ControllerHelper.parse_response(account)
      refute Map.has_key?(parsed_account, :__meta__)
    end

    test "when input is a struct" do
      input = %{key: "data"}

      assert ControllerHelper.parse_response(input) == {:ok, input}
    end

    test "return error parse" do
      assert ControllerHelper.parse_response({:error, []}) ==
               {:unprocessable_entity, %{errors: []}}
    end

    test "when resp is nil send not found" do
      assert ControllerHelper.parse_response(nil) == {:not_found, %{errors: "not found"}}
    end

    test "parse ectochangeset errors" do
      attrs = %{}
      account = Changeset.build(%Account{}, attrs)

      assert {:unprocessable_entity, %{errors: %{}}} =
               ControllerHelper.parse_response({:error, account})
    end
  end
end
