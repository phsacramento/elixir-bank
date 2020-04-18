defmodule Bank.BankAccount.ChangesetTest do
  @moduledoc false

  use Bank.DataCase, async: true

  alias Bank.Account
  alias Bank.BankAccount.Changeset

  describe "account struct" do
    test "validate fields" do
      assert %{
               birth_date: nil,
               city: nil,
               country: nil,
               cpf: nil,
               cpf_hash: nil,
               email: nil,
               gender: nil,
               name: nil,
               state: nil,
               status: :PENDING,
               referral_code: nil
             } = %Account{}
    end
  end

  describe "build/2" do
    test "with valid cpf should be valid" do
      attrs = %{cpf: "03480282539"}
      changeset = Changeset.build(%Account{}, attrs)
      assert changeset.valid?
    end

    test "with blank cpf should be invalid" do
      attrs = %{cpf: nil}
      changeset = Changeset.build(%Account{}, attrs)
      refute changeset.valid?

      assert changeset.errors == [
               cpf: {"can't be blank", [validation: :required]}
             ]
    end

    test "with invalid cpf should be invalid" do
      attrs = %{cpf: "000000000000"}
      changeset = Changeset.build(%Account{}, attrs)
      refute changeset.valid?

      assert changeset.errors == [
               cpf: {"Invalid Cpf", [validation: :cpf]}
             ]
    end
  end
end
