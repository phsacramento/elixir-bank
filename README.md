# Elixir Bank

Elixir Bank é uma aplicação com propósitos de estudos.

Aplicação de Exemplo:

https://app-elixir-banking.herokuapp.com/

## Como rodar numa máquina local

Você deve rodar utilizando elixir 1.10.2 e Phoenix 1.4.16

| Recomendo utilizar asdf (plugin de gerenciamento de versão), para instalar o Erlang e o Elixir.

* [asdf](https://github.com/asdf-vm/asdf)
* [asdf-erlang](https://github.com/asdf-vm/asdf-erlang)
* [asdf-elixir](https://github.com/asdf-vm/https://github.com/asdf-vm/asdf-elixir)

### Setup do Cloak Ecto

Biblioteca utilizada para lidar com encriptação de dados.

```shell
$ iex
32 |> :crypto.strong_rand_bytes() |> Base.encode64()
"aJ7HcM24BcyiwsAvRsa3EG3jcvaFWooyQJ+91OO7bRU="
```

**O base64 gerado precisa estar disponível numa variável de ambiente antes de rodar a aplicação** 

```shell
export CLOAK_KEY="A7x+qcFD9yeRfl3GohiOFZM5bNCdHNu27B0Ozv8X4dE="
```

### Setup do banco de dados

A aplicação roda com os dados padrão do postgresql

Usuário: `postgres`
Senha: `postgres`

Porém se você seus dados de usuário são diferences simplemente deixo os mesmos disponíveis em variáveis de ambiente.

```shell
export POSTGRES_USER=""
export POSTGRES_PASSWORD=""
export POSTGRES_DB=""
export POSTGRES_HOST=""
```

### Subindo a aplicação

```shell
$ mix deps.get
$ mix ecto.create
$ mix ecto.migrate
$ mix phx.server
```

Para rodar os testes execute:

```shell
$ mix test
$ mix credo
```

## Como funciona

A aplicação foi escrita utilizando 1.10.2 e expoẽ uma API REST através do Phoenix Framework.

### Modelagem

Existem dois modelos principais na modelagem, `Account` e `Inviation`.

#### Account

Responsável por lidar com os dados relacionados a cada Conta.

- Criptografa dados sensíveis.
- Altera o status da conta de `PENDING` para `COMPLETE` sempre que todos os dados de conta forem todos preenchidos.
- Não permite a criação de multiplas `Accounts` com o mesmo `cpf`.
- Gera um código de convite uma única vez quando status da `Account` muda para `COMPLETE`.

#### Invitation

Responsável por lidar com os convites para criação de novas contas.
Como um usuário com uma `Account` com status complete posso fornecer meu `código de convite` para que
outros usuários possam criar `Accounts` através do mesmo.

- Utiliza um Código de Convite `ReferralCode` para localizar uma `Account` relacionada.
- Utiliza um para indificar as contas criadas através de convite `referral_account_id`.

## API Rest

Expoẽ uma API rest privada, que necessita de um Token válido para realizar requests.

### Como gerar um token válido

```shell
$ iex -S mix
$ {:ok, token, _} = BankWeb.Tokens.AuthenticationToken.generate_and_sign()
$ token # retorna um token válido para ser usado na request
```

### Endpoints

#### POST /api/accounts [create] (permite a criação de contas e uma ou multiplas requests)

- Permite a criação de contas com uma ou mais requests, atributo obrigatório é o `cpf`.

Atributos

- `cpf` String - obrigatório
- `birth_date` String
- `name` String
- `email` String
- `gender` Enum - MALE ou FEMALE
- `state` String
- `city` String
- `country` String
- `referral_code` String (precisa ser um código existente válido)

| Exemplo de request para criação de conta

Header

```authorization Bearer token válido```

```json
{
	"cpf": "861.370.560-07",
	"name": "Paulo Henrique dos Santos Sacramento",
	"birth_date": "06/01/2990",
	"email": "contato@henriquesacramento.net",
	"gender": "MALE",
	"state": "BA",
	"city": "Teixeira de Freitas",
    "country": "BR"
}
```

Curl:

```shell
curl --location --request POST 'http://localhost:4000/api/accounts' \
--header 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKb2tlbiIsImV4cCI6MTU4NzQ5OTAyMSwiaWF0IjoxNTg3NDkxODIxLCJpc3MiOiJKb2tlbiIsImp0aSI6IjJvM3VlcGtrY3NyY3NxZnRqczAwMDA5MSIsIm5iZiI6MTU4NzQ5MTgyMX0.ka_yeOhthqqcISMkQHadUWM_jzzsEMRWfgXirYN44dM' \
--form 'cpf=861.370.560-07' \
--form 'name=Paulo Henrique dos Santos Sacramento' \
--form 'birth_date=06/01/2990' \
--form 'email=contato@henriquesacramento.net' \
--form 'gender=MALE' \
--form 'state=BA' \
--form 'city=Teixeira de Freitas' \
--form 'country=BR'
```

Retorno esperado

```json
{
  "cpf": "861.370.560-07",
  "id": "d7cb33af-27c0-41dc-b6f6-67a54766dbc6",
  "invitation_code": "OiFWmBsQ",
  "name": "Paulo Henrique dos Santos Sacramento",
  "status": "COMPLETE"
}```

| Exemplo de request utilizando referral_code

```json
{
	"cpf": "861.370.560-07",
	"name": "Paulo Henrique dos Santos Sacramento",
	"birth_date": "06/01/2990",
	"email": "contato@henriquesacramento.net",
	"gender": "MALE",
	"state": "BA",
	"city": "Teixeira de Freitas",
    "country": "BR",
    "referral_code": "ArvBFSHJ"
}
```

Curl:

```shell
curl --location --request POST 'http://localhost:4000/api/accounts' \
--header 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKb2tlbiIsImV4cCI6MTU4NzQ5OTAyMSwiaWF0IjoxNTg3NDkxODIxLCJpc3MiOiJKb2tlbiIsImp0aSI6IjJvM3VlcGtrY3NyY3NxZnRqczAwMDA5MSIsIm5iZiI6MTU4NzQ5MTgyMX0.ka_yeOhthqqcISMkQHadUWM_jzzsEMRWfgXirYN44dM' \
--form 'cpf=279.794.900-53' \
--form 'name=Paulo Henrique dos Santos Sacramento' \
--form 'birth_date=06/01/2990' \
--form 'email=contato@henriquesacramento.net' \
--form 'gender=MALE' \
--form 'state=BA' \
--form 'city=Teixeira de Freitas' \
--form 'country=BR' \
--form 'referral_code=ArvBFSHJ'
```

#### POST /api/referrals [index] (lista as indicações feitas por determinado cpf)

Atributos

- `cpf` String - obrigatório

| Exemplo de request para listagem de indicações

Header

```authorization Bearer token válido```

```json
{
    "cpf": "087.493.230-08"
}

Retorno Esperado

```json
[
    {
        "account_id": "f54452ca-108d-4306-a82d-e607a11f4ac1",
        "email": "contato@henriquesacramento.net",
        "inserted_at": "2020-04-21T19:12:45"
    }
]
```

Curl:

```shell
curl --location --request POST 'http://localhost:4000/api/referrals' \
--header 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKb2tlbiIsImV4cCI6MTU4NzQ5OTAyMSwiaWF0IjoxNTg3NDkxODIxLCJpc3MiOiJKb2tlbiIsImp0aSI6IjJvM3VlcGtrY3NyY3NxZnRqczAwMDA5MSIsIm5iZiI6MTU4NzQ5MTgyMX0.ka_yeOhthqqcISMkQHadUWM_jzzsEMRWfgXirYN44dM' \
--form 'cpf=569.576.010-05'
```

### Contributing

Envie suas alterações
-------------------------

A melhor maneira de enviar alterações para o Elixir Bank é fazer um fork do nosso repo e abrir um Pull Request.
GitHub possui um guia [como enviar um fork pull request] no próprio website.

[como enviar um fork pull request]: https://help.github.com/articles/fork-a-repo/

Você pode utilizar o CLI [hub](https://hub.github.com/) para fazer isso.
Da seguinte forma,
Você pode enviar o pull request do seu fork com os seguintes comandos:

    $ hub clone phsacramento/elixir-bank
    $ cd elixir-bank
    $ hub fork
    $ git checkout -b fix_readme
    $ vim CONTRIBUTING.md
    $ git commit CONTRIBUTING.md
    $ git push -u <YOUR GITHUB USERNAME> HEAD
    $ hub pull-request


### Author

Paulo Henrique Sacramento (@phsacramento)
