class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre

  validates :name, presence: true
  validates :price, presence: true
  validates :introduction, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  validates :image, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def with_tax_price
    (price * 1.1).round
  end
end
