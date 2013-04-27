ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc { I18n.t("active_admin.dashboard") }

  content :title => proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Contestant Data", id: "contestant_data" do
          render "admin/contestant_data"
        end
      end
    end
  end

  controller do
    def index
      if params[:entry].try(:[], :id).present?
        @entry = Entry.find(params[:entry][:id])
        @user = @entry.user
      end
    end
  end
end
