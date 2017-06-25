class User < ApplicationRecord
  authenticates_with_sorcery!

  class << self
    def login(params)
      User.authenticate(*params.values_at(:email, :password))
    end

    def current_user(headers)
      token = headers[:Authorization].to_s.split.last
      return unless token
      payload, _header = JWT.decode(token, Rails.application.secrets.secret_key_base)
      find_by(email: payload["email"])
    end
  end

  def auth_token
    JWT.encode({ email: email }, Rails.application.secrets.secret_key_base)
  end
end
