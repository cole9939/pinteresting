ActiveAdmin.register User do

  permit_params :name, :email, :url, :password, :password_confirmation
 
  index do                           
    column :id
    column :name
    column :url
    column :email                    
    default_actions             
    column "SignIn" do |user|
      link_to "SignIn", login_via_super_admin_path(:id => user), :target => "_blank"   
    end
  end 

  filter :name
  filter :email

  form do |f|                        
    f.inputs "User Details" do      
      f.input :name
      f.input :email
      f.input :password
      f.input :url
    end                              
    f.actions                        
  end
   
end
