ActiveAdmin.register Block do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  # sidebar "Детали", only: [:show, :edit] do
  #   ul do
  #     li link_to "Карточки", admin_block_cards_path(block)
  #   end
  # end

  index do
    id_column
    column :title
    column :cards do |block|
      link_to "cards", admin_block_cards_path(block)
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :cards do |block|
        link_to "cards", admin_block_cards_path(block)
      end
      row :created_at
      row :updated_at
      row :user
    end
  end

end
