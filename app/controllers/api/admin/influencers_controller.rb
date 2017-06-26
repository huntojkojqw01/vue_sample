module Api
  module Admin
    class InfluencersController < Admin::ApplicationController
      def index
        records = sort(filter(::Influencer.all))
        render json: { meta: { count: records.count }, data: paginate(records) }
      end

      def show
        influencer = ::Influencer.find(params[:id])
        render json: { data: influencer }
      end

      def create
        influencer = ::Influencer.new(influencer_params)

        if influencer.save
          head :ok
        else
          render_validation_error(influencer)
        end
      end

      def update
        influencer = ::Influencer.find(params[:id])
        influencer.attributes = influencer_params

        if influencer.save
          head :ok
        else
          render_validation_error(influencer)
        end
      end

      def destroy
        ::Influencer.destroy(params[:id])
        head :ok
      end

      private

      def filter(records)
        name  = params.dig(:filter, :name)
        email = params.dig(:filter, :email)
        records = records.where("name LIKE ?", "%#{name}%")   if name.present?
        records = records.where("email LIKE ?", "%#{email}%") if email.present?
        records
      end

      def sort(records)
        order_params = params[:sort].to_s.split(",").map do |sort|
          [sort.delete("-"), sort.start_with?("-") ? :desc : :asc]
        end.to_h
        records.order(order_params)
      end

      def paginate(records)
        page = params.dig(:page, :number)&.to_i || 1
        size = params.dig(:page, :size)&.to_i || 20
        records.page(page).per(size)
      end

      def influencer_params
        params.permit(:name, :email)
      end
    end
  end
end
