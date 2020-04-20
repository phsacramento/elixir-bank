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

  describe "create_or_update" do
    test "create account" do
      cpf = Brcpfcnpj.cpf_generate()

      attrs = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: "12345678"
      }

      assert {:ok, %{cpf: cpf}} = Mutator.create(attrs)
      assert Loader.get(cpf)
    end

    test "update account" do
      cpf = Brcpfcnpj.cpf_generate()

      attrs = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: "12345678"
      }

      Mutator.create(attrs)

      update_attrs = %{
        cpf: cpf,
        city: "São Paulo"
      }

      assert {:ok, %{cpf: _}} = Mutator.create_or_update(update_attrs)
      account = Loader.get(cpf)
      assert account
      assert account.cpf == cpf
      assert account.city == "São Paulo"
    end

    test "not allow accounts with same cpf" do
      cpf = "03480282539"

      attrs = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        country: "BR",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: "12345678",
        status: :COMPLETE
      }

      Mutator.create_or_update(attrs)

      update_attrs = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: "12345678"
      }

      assert {:error, %{}} = Mutator.create_or_update(update_attrs)
    end
  end

  describe "update/2" do
    test "update an transactions attributes" do
      cpf = Brcpfcnpj.cpf_generate(true)

      attrs = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: "12345678"
      }

      Mutator.create_or_update(attrs)

      account = Loader.get(cpf)

      new_attributes = %{
        name: "Henrique Sacramento"
      }

      assert {:ok, _} = Mutator.update(account, new_attributes)
    end

    test "invalid attrs" do
      cpf = Brcpfcnpj.cpf_generate()

      attrs = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: "12345678"
      }

      {:ok, account} = Mutator.create_or_update(attrs)

      new_attributes = %{
        cpf: ""
      }

      assert {:error, _} = Mutator.update(account, new_attributes)
    end
  end
end
