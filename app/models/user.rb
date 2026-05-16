# email: string
# password_digest: string
# password: string virtual
# password_confirmation: string virtual

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }

  def generate_password_reset_token
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!
  end

  def password_reset_expired?
    password_reset_sent_at < 2.hours.ago
  end
end
