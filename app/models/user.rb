class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #フォロー機能
  #フォローしてる
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #フォローされてる
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  #フォローしているユーザー一覧
  has_many :following, through: :active_relationships, source: :followed
  #フォロワー一覧
  has_many :followers, through: :passive_relationships, source: :follower



  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  
  validates :introduction, length: { maximum: 50 }
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end


  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id)&.destroy
  end
  
  def following?(other_user)
    active_relationships.exists?(followed_id: other_user.id)
  end
  
  def self.search_for(word, method)
    if method == 'perfect'
      User.where(name: word)
    elsif method == 'forward'
      User.where('name LIKE ?', "#{word}%")
    elsif method == 'backward'
      User.where('name LIKE ?', "%#{word}")
    else
      User.where('name LIKE ?', "%#{word}%")
    end
  end

end
