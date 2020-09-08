class Album < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many:photos
  has_many :likes, as: :likeable
  validates :title, presence: true, length: {maximum: 140,minimum:10, message:"max",message:"SERVER: AT LEAST 10 CHARACTERS"}
  validates :description,length: {maximum: 300}
  before_save :ensure_description_has_value
  private
    def ensure_description_has_value
      unless self.description.present?
        self.description= "This is album of user has id " + self.user_id.to_s
      end
    end
end
