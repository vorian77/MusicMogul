ActiveAdmin.register CampaignLink do
  form do |f|
    f.inputs do
      f.input :description
    end
    f.actions
  end

  show do |campaign_link|
    attributes_table do
      row :description
      row :shortened_link
      row :artist_sign_up_count do
        campaign_link.artist_sign_ups.count
      end
      row :fan_sign_up_count do
        campaign_link.fan_sign_ups.count
      end
      row :created_at
    end
  end

  index do
    column :description
    column :shortened_link
    column :artist_sign_up_count do |campaign_link|
      campaign_link.artist_sign_ups.count
    end
    column :fan_sign_up_count do |campaign_link|
      campaign_link.fan_sign_ups.count
    end
    column :created_at
    default_actions
  end
end
