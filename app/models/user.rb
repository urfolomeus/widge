class User < ActiveRecord::Base
  authenticates_with_sorcery!

  before_validation :downcase_email
  before_create :generate_api_token

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, length: { minimum: 3 }, confirmation: true
  validates :password_confirmation, presence: true

  attr_accessor :password_confirmation

  private

  def downcase_email
    self.email = self.email.try(:downcase)
  end

  def generate_api_token
    self.api_token = SecureRandom.uuid
  end
end
