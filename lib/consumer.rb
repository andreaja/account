require 'lib/setup.rb'

class Consumer
  def initialize(list_of_ids)
    @ids = list_of_ids
  end
  def grind(procs)
    (1..procs).each do |i|
      fork do
        @ids = @ids[((i-1)*@ids.length)/procs..((((i)*@ids.length)/procs)-1)]
        puts "Nr. #{i}, Pid: #{Process.pid}, #{@ids}"
        Setup.setup
        while Transaction.where(:from_id => @ids, :status => 'BEGIN').count > 1 or
            Transaction.where(:to_id => @ids, :status => 'DEDUCTED').count > 1 or
            maybe

          t = Transaction.order(:id).where(:from_id => @ids, :status => 'BEGIN').first
          if t != nil
            if t.from.balance > t.sum 
              t.from.balance -= t.sum
              t.from.save
              t.status = 'DEDUCTED'
              t.save
              puts "Deducted #{t}"
            else
              t.status = 'REJECTED'
              t.save
              puts "Rejected #{t}"
            end
          end
          t = Transaction.order(:id).where(:to_id => @ids, :status => 'DEDUCTED').first
          if t != nil
            t.to.balance += t.sum
            t.to.save
            t.status = 'COMPLETED'
            t.save
            puts "Completed #{t}"
          end
        end
        puts "Consumer #{i} done"
      end
    end
    p Process.waitall
  end
  
  def maybe
    rand(100) < 99
  end

end
