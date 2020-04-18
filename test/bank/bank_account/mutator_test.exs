defmodule Bank.BankAccount.MutatorTest do
  @moduledoc false

  use Bank.DataCase, async: true

  alias Bank.BankAccount.Loader
  alias Bank.BankAccount.Mutator

  describe "create/1" do
    test "with valid attributes" do
      cpf = Brcpfcnpj.cpf_generate()

      attrs = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: "12345678"
      }

      assert {:ok, %{cpf: cpf}} = Mutator.create(attrs)
      assert Loader.get(cpf)
    end

    test "with invalid cpf" do
      attrs = %{cpf: nil}
      assert {:error, %{}} = Mutator.create(attrs)
    end
  end
end
