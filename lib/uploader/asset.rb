module Uploader
  module Asset
    # Save asset
    # Usage:
    #
    #   class Asset < ActiveRecord::Base
    #     include Uploader::Asset
    #     
    #     def uploader_create(params, request = nil)
    #       self.user = request.env['warden'].user
    #       super
    #     end
    #   end
    #
    def uploader_create(params, request = nil)
      self.guid = params[:guid]
      self.assetable_type = params[:assetable_type]
      if self.class.respond_to?(:collection) && !params[:assetable_id].blank?
        self.assetable_id = Moped::BSON::ObjectId.from_string(params[:assetable_id])
      else
        self.assetable_id = params[:assetable_id]
      end

      save
    end

    # Destroy asset
    # Usage (cancan example):
    #
    #   class Asset < ActiveRecord::Base
    #     include Uploader::Asset
    #     
    #     def uploader_destroy(params, request = nil)
    #       ability = Ability.new(request.env['warden'].user)
    #       if ability.can? :delete, self
    #         super
    #       else
    #         errors.add(:id, :access_denied)
    #       end
    #     end
    #   end
    #
    def uploader_destroy(params, request)
      destroy
    end
  end
end
