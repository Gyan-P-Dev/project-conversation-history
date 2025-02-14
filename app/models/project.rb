class Project < ApplicationRecord
  validates :name, :status, presence: true

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :notifications, dependent: :destroy

  enum :status, { open: 0, closed: 1, archived: 2 }, default: :open

  after_initialize :set_default_status, if: :new_record?

  def self.ransackable_attributes(auth_object = nil)
    super + %w[id name status user_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  ransacker :status_name do
    Arel.sql("CASE status
              WHEN 0 THEN 'open'
              WHEN 1 THEN 'closed'
              WHEN 2 THEN 'archived'
              END")
  end
  
  private

  def set_default_status
    self.status ||= :open
  end
end
