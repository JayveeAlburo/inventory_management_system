class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_error

  validates :name, presence: { message: "Name can't be blank" },
  uniqueness: { message: "Category name already exists" },
  length: { maximum: 100, message: "Name is too long (maximum is 100 characters)" }

  validates :description, length: { maximum: 500, message: "Description is too long (maximum is 500 characters)" }, allow_blank: true

  scope :ordered, -> { order(created_at: :desc) }
end