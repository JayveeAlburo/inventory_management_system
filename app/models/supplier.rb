class Supplier < ApplicationRecord
  has_many :products, dependent: :restrict_with_error

  STATUS_OPTIONS = %w[active inactive].freeze

  validates :company_name, presence: { message: "Company name can't be blank" },
  uniqueness: { message: "Company name already exists" },
  length: { maximum: 150, message: "Company name is too long (maximum is 150 characters)" }

  validates :contact_person, presence: { message: "Contact person can't be blank" },
  length: { maximum: 100, message: "Contact person is too long (maximum is 100 characters)" }

  validates :email, presence: { message: "Email can't be blank" },
  format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email must be a valid email address" }

  validates :status, inclusion: { in: STATUS_OPTIONS, message: "Status must be active or inactive" }

  validates :phone, length: { maximum: 50, message: "Phone is too long (maximum is 50 characters)" }, allow_blank: true
  validates :address, length: { maximum: 500, message: "Address is too long (maximum is 500 characters)" }, allow_blank: true
  validates :notes, length: { maximum: 1000, message: "Notes are too long (maximum is 1000 characters)" }, allow_blank: true

  scope :ordered, -> { order(created_at: :desc) }
  scope :active, -> { where(status: 'active') }
  scope :inactive, -> { where(status: 'inactive') }
end