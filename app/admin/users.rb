ActiveAdmin.register User do
  index do
    column :id
    column :username
    column :email
    column "Inviter" do |user|
      link_to user.inviter.username, user.inviter if user.inviter.present?
    end
    column :confirmed_at
    column :profile_photo
    column :referral_token
    column :shortened_referral_link
    column :musician
    column :cached_points
    column :created_at
    column :updated_at
  end
end
