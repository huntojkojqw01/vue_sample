module Api
  class ApplicationController < ::ApplicationController
    before_action :authenticate!

    private

    def authenticate!
      head :unauthorized unless current_user
    end

    def render_validation_error(model)
      render status: :unprocessable_entity, json: { errors: model.errors }
    end
  end
end
