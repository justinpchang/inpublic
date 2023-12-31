# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  about                  :string
#  avatar                 :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  username               :string           not null
#  website                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  include Subscribable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         jwt_revocation_strategy: JwtDenylist

  mount_uploader :avatar, AvatarUploader

  has_many :projects, dependent: :destroy
  has_many :updates, through: :projects
  has_many :upvotes, dependent: :destroy
  has_many :upvoted_updates, through: :upvotes, source: :update

  validates :name, presence: true, length: { minimum: 1 }
  validates :username,
            presence: true,
            format: {
              with: /\A[A-Z0-9]+\z/i,
            },
            uniqueness: {
              case_sensitive: false,
            },
            length: {
              minimum: 3,
              maximum: 20,
            }
  validates :email,
            presence: true,
            uniqueness: {
              case_sensitive: false,
            },
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
            }
end
