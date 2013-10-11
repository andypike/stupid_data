require 'rubygems'
require 'bundler/setup'
require 'stupid_data'

# Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.order = 'random'

  config.before(:suite) do
    puts "Recreating test database..."
    conn = PG.connect(dbname: "postgres")
    conn.exec("DROP DATABASE IF EXISTS stupid_data;")
    conn.exec("CREATE DATABASE stupid_data;")

    setup = File.read("./spec/support/setup_database.sql")
    conn = PG.connect(dbname: "stupid_data")
    conn.exec(setup)
    puts "Done"
  end
end