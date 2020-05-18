class Medium < ApplicationRecord
    mount_uploader :media_name, ImageUploader
end
