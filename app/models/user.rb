class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :galleries, dependent: :destroy
  has_many :products, dependent: :destroy
  # has_many :categories, dependent: :destroy
  has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    self.first_name + " " + self.last_name
  end
end
