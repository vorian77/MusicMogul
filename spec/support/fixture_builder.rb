FixtureBuilder.configure do |config|
  config.record_name_fields = %w{ first_name name }
  config.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb"]
  config.select_sql = %Q{ SELECT * FROM %s }
  config.delete_sql = %Q{ DELETE FROM %s }
  config.skip_tables = %w( delayed_jobs schema_migrations )

  config.factory do
    config.name :confirmed_user, FactoryGirl.create(:confirmed_user)
    FactoryGirl.create_list(:entry, 3)
    FactoryGirl.create(:evaluation, user: User.first, entry: Entry.all.sample)
  end
end