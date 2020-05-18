class User < ApplicationRecord
    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness: true}
    validates :password, {presence: true}
    
    def posts
      return Post.where(user_id: self.id)
    end
    
    def image
      return Medium.find_by(post_id: self.id)
    end

end
