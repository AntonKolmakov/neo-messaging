class User < ApplicationRecord
  has_one :inbox
  has_one :outbox
  has_many :payments
  has_many :messages

  scope :patient, -> { where(is_patient: true) }
  scope :admin, -> { where(is_admin: true) }
  scope :doctor, -> { where(is_doctor: true) }

  class << self
    def current
      User.patient.first
    end
  
    def default_admin
      User.admin.first
    end
  
    def default_doctor
      User.doctor.first
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end