import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :airwander3, Airwander3Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "7oIGpZZnNeH2HHCaf4mAQkw4sKJqgxmd6ms9EmCLW0zLDn0KV5VJq4FcCiB89RGF",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
