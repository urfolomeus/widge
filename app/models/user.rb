class User < ActiveRecord::Base
  authenticates_with_sorcery!

  before_validation :downcase_email

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, length: { minimum: 3 }, confirmation: true
  validates :password_confirmation, presence: true

  attr_accessor :password_confirmation

  private

  def downcase_email
    self.email = self.email.try(:downcase)
  end
end
