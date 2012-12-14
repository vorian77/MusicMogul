class AddShortenedReferralLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shortened_referral_link, :string
  end
end
