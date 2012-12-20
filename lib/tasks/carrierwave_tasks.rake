namespace :carrierwave do
  namespace :reprocess do
    desc "Reprocess entry images"
    task :entry => :environment do 
      Entry.all.each do |entry|
        puts "Reprocessing #{entry.profile_photo} for entry ##{entry.id}..."
        entry.profile_photo.recreate_versions! rescue "Entry had no photo."
      end
    end

    desc "Reprocess user images"
    task :user => :environment do 
      User.all.each do |user|
        puts "Reprocessing #{user.profile_photo} for user ##{user.id}......"
        user.profile_photo.recreate_versions! rescue "User had no photo."
      end
    end
  end
end
