class Transaction < ActiveRecord::Base
  belongs_to :invoice

  scope :successful, -> { where(result: "success") }

  def self.unsuccessful
    where(result: "failed")
  end
end
