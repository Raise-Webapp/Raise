class DuctLine < ApplicationRecord
  has_many :ducts, dependent: :destroy
  has_one_attached :image
  has_one_attached :pdf_document
  
  validates :name, presence: true
end