<%if params[:type]=="website" %>
$("#website").html("<%= j render('users/website_like') %>")

<%end%>