class Book < ApplicationRecord
  belongs_to :user
  
#   バリデーション
validates :title, presence: true

validates :body, presence: true, length: {maximum: 200}

# validates :create, presence: true

end

