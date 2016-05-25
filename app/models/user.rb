class User < ActiveRecord::Base

    def self.from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name = auth_hash['info']['name']
      user.image_url = auth_hash['info']['image']
      user.save!
      user
    end

    def self.create_with_omniauth(auth)
      # raise auth
      create! do |user|

        user.provider = auth['provider']
        user.uid = auth['uid']
        if auth['info']
          user.name = auth['info']['name'] || ""
        end
      end
    end
end