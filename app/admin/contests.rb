ActiveAdmin.register Contest do
  form do |f|
    f.inputs do
      f.input :start_date
      f.input :end_date
      f.input :show_contestants
      f.input :leaderboard_display, collection: Contest::LEADERBOARD_DISPLAY_OPTIONS, include_blank: false
    end
    f.actions
  end
end
