ActiveAdmin.register User do
  index do
    column :id
    column :username
    column :email
    column "Inviter Id" do |user|
      link_to user.inviter_id, user.inviter if user.inviter.present?
    end
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

  csv do
    column :id
    column :username
    column :email
    column "Inviter Id" do |user|
      user.inviter_id if user.inviter.present?
    end
    column :inviter do |user|
      user.inviter.username if user.inviter.present?
    end
    column :created_at
    column :updated_at
    column :encrypted_password
    column :reset_password_token
    column :reset_password_sent_at
    column :remember_created_at
    column :sign_in_count
    column :current_sign_in_at
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    column :confirmation_token
    column :confirmed_at
    column :confirmation_sent_at
    column :unconfirmed_email
    column :hometown
    column :admin
    column :show_explicit_videos
    column :receive_email_updates
    column :profile_photo
    column :referral_token
    column :shortened_referral_link
    column :musician
    column :tos
    column :time_zone
    column :cached_points
  end
end
