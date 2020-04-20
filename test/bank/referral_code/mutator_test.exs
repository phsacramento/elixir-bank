defmodule Bank.ReferralCode.MutatorTest do
  @moduledoc false

  use Bank.DataCase, async: true

  alias Bank.ReferralCode.Loader
  alias Bank.ReferralCode.Mutator

  describe "create/1" do
    test "with valid attributes" do
      code = "12345678"
      account_id = Ecto.UUID.generate()

      attrs = %{
        account_id: account_id,
        code: code
      }

      assert {:ok, %{code: code}} = Mutator.create(attrs)
      assert Loader.get(code)
    end

    test "with invalid code" do
      account_id = Ecto.UUID.generate()
      attrs = %{code: nil, account_id: account_id}
      assert {:error, %{}} = Mutator.create(attrs)
    end

    test "with invalid account_id" do
      attrs = %{code: "12345678", account_id: ""}
      assert {:error, %{}} = Mutator.create(attrs)
    end
  end
end
