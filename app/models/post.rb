class Post < ApplicationRecord
    
    def user
      return User.find_by(id: self.user_id)
    end

    def image
      return Medium.find_by(post_id: self.id)
    end

    

end
