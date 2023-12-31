# frozen_string_literal: true
# typed: true

module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json

      before_action :authenticate_user!, only: %i[update me avatar]
      before_action :set_user!, only: %i[show]

      def show
        @current_user_id = current_user&.id
      end

      def update
        user = params.require(:user)
        current_user.update!(name: user['name'], about: user['about'], website: user['website'])
        render partial: 'users/user', locals: { user: current_user }
      end

      # Get current user
      def me
        render partial: 'users/user', locals: { user: current_user }
      end

      def avatar
        avatar = params.require(:avatar)
        current_user.update!(avatar: avatar)
        render partial: 'users/user', locals: { user: current_user }
      end

      def check_username
        username = params.require(:username)
        render json: { available: !User.exists?(username: username) }
      end

      private

      def set_user!
        @user = User.find_by!(username: params[:username])
      end
    end
  end
end
