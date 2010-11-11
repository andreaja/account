require 'rubygems'
require 'logger'
require 'yaml'
require 'sqlite3'
require 'active_record'

class Setup
  def self.setup
    ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/../log/debug.log')
    ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + '/../config/database.yml'))
    ActiveRecord::Base.establish_connection('sqlite')
  end
end
