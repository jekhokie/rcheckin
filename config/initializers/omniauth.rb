Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '142995612507886', '20fb59252d8210e4ffef168a233af8cf'
end
