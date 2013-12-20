ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    section("Recent 10 Users") do
      ul do
        User.limit(10).order('created_at desc').collect do |user|
          li link_to(user.email, "#")
        end
      end
    end
  end

end
