namespace :carrierwave do
  namespace :reprocess do
    desc "reprocess all image sizes"
    task :all do 
      instance = ProfilePhotoUploader.new
      instance.recreate_versions!(:large, :medium, :thumb, :masonry)
    end

    desc "reprocess masonry-sized images"
    task :masonry do 
      instance = ProfilePhotoUploader.new
      instance.recreate_versions!(:masonry)
    end
  end
end
