defmodule SlackPosting.ExAdmin.Post do
  use ExAdmin.Register

  register_resource SlackPosting.Journals.Post do
    show post do
      attributes_table do
        row :user_name
        row :text
        row :slack_id
      end

      panel "Tags" do
        markup_contents do
          ul do
            for tag <- post.tags do
              li do
                a href: admin_resource_path(tag, :show) do
                  tag.name
                end
              end
            end
          end
        end
      end
    end
    query do
      %{
        show: [
          preload: [
            :tags
          ]
        ],
      }
    end
  end
end
