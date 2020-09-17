class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  def active_for_authentication?
    super and self.active?
  end

  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :first_name, presence: true, length: {maximum: 25}, format: { with: /\A[a-zA-Z]+\z/}, uniqueness: {scope: :last_name}
  validates :last_name, presence: true, length: {maximum: 25}, format: { with: /\A[a-zA-Z]+\z/}
  validates :email, presence: true, length: {maximum: 255}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, uniqueness:true
  # validates :password, presence:true, confirmation: true, length: {minimum: 8,maximum: 64, message: "Your password must has at least 8 and at most 64 characters!"}
  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"
  has_many :followers, through: :received_follows, source: :follower
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :given_follows, source: :followed_user
  mount_uploader :image, ImageUploader

  before_destroy :sendmail
  private
    def sendmail
      UserMailer.delete_email(self).deliver_now
    end
end
