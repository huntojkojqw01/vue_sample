module Api
  module Admin
    class SessionsController < Admin::ApplicationController
      skip_before_action :authenticate!

      def create
        user = User.login(params)

        if user
          render json: { jwt: user.auth_token, name: user.email }
        else
          head :unprocessable_entity
        end
      end
    end
  end
end
