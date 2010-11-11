require 'lib/setup.rb'

class Producer
  def initialize(list_of_ids)
    @list_of_owned_ids = list_of_ids
    Setup.setup
  end
  def grind(count)
    (1..count).each do |i|
      from = random_account
      begin
        to = random_account
      end while from.id == to.id
      sum = rand(100) + 1
      t=Transaction.new(:from => from,
                        :to => to,
                        :sum => sum,
                        :status => "BEGIN")
      t.save
    end
  end
  def random_account
    r = rand(@list_of_owned_ids.length)
    id = @list_of_owned_ids[r]
    return Account.find(id)
  end
end
