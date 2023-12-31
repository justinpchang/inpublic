# frozen_string_literal: true
# typed: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { success: true }
  end

  def register_failed
    render json: { success: false, errors: resource.errors.full_messages.to_sentence.humanize }
  end
end
