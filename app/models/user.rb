class User < ApplicationRecord
  has_one_attached :profile_image
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books, dependent: :destroy
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  validates :name, length: {minimum: 2,maximum: 20}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  # いらない
  # def create
  #   @user = User.new(user_params)
  #   @user.user_id = current_user.id
  #   if @user.save
  #     redirect_to user_path
  #   else
  #     render :new
  #   end
  # end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

end
