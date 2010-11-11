require 'rubygems'
require 'active_record'
require 'yaml'
require 'logger'
require 'lib/populate.rb'
require 'lib/account.rb'
require 'lib/setup.rb'
require 'lib/producer.rb'
require 'lib/consumer.rb'
require 'lib/transaction.rb'

task :default => :nothing

task :crunch => :environment do
  puts "Number of accounts: #{Account.count}"
  count = Account.count
  fork do
    Producer.new((1..count).to_a).grind(100)
  end
  sleep 0.5
  fork do
    Consumer.new((1..count).to_a).grind(5)
  end
  p Process.waitall
end

task :populate => :environment do
  Populate.lots_of_accounts(100)
end

task :migrate => :environment do
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

task :environment do
  Setup.setup
end
