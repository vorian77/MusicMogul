namespace :carrierwave do
  desc "reprocess all image sizes"
  task :reprocess => :environment do 
    User.all.each do |user|
      user.profile_photo.recreate_versions! rescue "User had no photo."
    end
  end
end
