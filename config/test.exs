use Mix.Config

# Configure your database
config :bank, Bank.Repo,
  username: "postgres",
  password: "postgres",
  database: "bank_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :joken,
  default_signer: "znetcsgxsKwQTuFSMFZ/DwqD/r3Olr9cXbiZac6AVGIMYkZkceozUiRF3nOzi6ZR"

config :bank, Bank.TestVault,
  json_library: Jason,
  ciphers: [
    default:
      {Cloak.Ciphers.AES.GCM,
       tag: "AES.GCM.V1", key: Base.decode64!("3Jnb0hZiHIzHTOih7t2cTEPEpY98Tu1wvQkPfq/XwqE=")},
    secondary:
      {Cloak.Ciphers.AES.CTR,
       tag: "AES.CTR.V1", key: Base.decode64!("o5IzV8xlunc0m0/8HNHzh+3MCBBvYZa0mv4CsZic5qI=")}
  ]

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bank, BankWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
