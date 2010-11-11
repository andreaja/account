class Transaction < ActiveRecord::Base
  belongs_to :from, :class_name => "Account"
  belongs_to :to, :class_name => "Account"
  def to_s
    "#{self.from.id} -> #{self.to.id} [#{self.sum}], #{self.status}"
  end
end
