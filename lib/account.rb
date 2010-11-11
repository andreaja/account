class Account < ActiveRecord::Base
  def to_s
    "#{self.id}, #{self.name}, #{self.balance}"
  end
end
