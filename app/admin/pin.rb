ActiveAdmin.register Pin do

  permit_params :image, :description
  
  index do |d|         
    column :id
    column :description
    default_actions             
  end 

  filter :user

  form do |f|                        
    f.inputs "Pin Details" do
      f.input :user
      f.input :image, :as => :file, :hint => f.template.image_tag(f.object.image.url(:medium), :style=>"width: 100px;")
      f.input :description
    end                              
    f.actions                        
  end
  
end
