class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :mentions, dependent: :destroy

  validates :username, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id email name created_at updated_at]
  end
end
