class Album < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :photos, dependent: :destroy
  validates :title, presence: true, length: {maximum: 140,minimum:10}
  validates :description,length: {maximum: 300}
  before_save :ensure_description_has_value
  private
    def ensure_description_has_value
      unless self.description.present?
        self.description= "This is album of user has id " + self.user_id.to_s
      end
    end
end
