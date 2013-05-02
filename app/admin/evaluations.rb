ActiveAdmin.register Evaluation do
  index do
    selectable_column
    column :id
    column :user_id
    column "Username" do |evaluation|
      evaluation.user.username
    end
    column :created_at
    column :updated_at
    column :entry_id
    column :comment
    column :music_score
    column :presentation_score
    column :vocals_score
    column :overall_score
    column :share_email
    default_actions
  end

  csv do
    column :id
    column :user_id
    column "Username" do |evaluation|
      evaluation.user.username
    end
    column :created_at
    column :updated_at
    column :entry_id
    column :comment
    column :music_score
    column :presentation_score
    column :vocals_score
    column :overall_score
    column :share_email
  end
end
