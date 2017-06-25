module Api
  module Admin
    class ApplicationController < ::Api::ApplicationController
      private

      def current_user
        @current_user ||= User.current_user(request.headers)
      end
    end
  end
end
