FixtureBuilder.configure do |config|
  config.record_name_fields = %w{ first_name name }
  config.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb"]
  config.select_sql = %Q{ SELECT * FROM %s }
  config.delete_sql = %Q{ DELETE FROM %s }
  config.skip_tables = %w( delayed_jobs schema_migrations )

  config.factory do
    config.name :confirmed_user, FactoryGirl.create(:confirmed_user, inviter: FactoryGirl.build(:user))
    3.times { FactoryGirl.create(:confirmed_user, musician: true) }
    Entry.find_each do |entry|
      entry.attributes = FactoryGirl.attributes_for(:entry).except(:user)
      entry.save
    end
    FactoryGirl.create(:evaluation, user: User.invited.first, entry: Entry.all.sample)
    FactoryGirl.create(:contest, start_date: Date.yesterday, end_date: Date.yesterday + 2.weeks)
    FactoryGirl.create(:site_configuration, allow_artist_signup: true)
  end
end