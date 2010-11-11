require 'digest/md5'

class Populate

  def self.lots_of_accounts(number)
    puts "Creating #{number} accounts with balance 100"

    (1..number).each do |i|
      Account.new(:name => Digest::MD5.hexdigest(i.to_s),
                  :balance => 100).save

    end
  end
end
