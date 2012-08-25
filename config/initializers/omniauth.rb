Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '142995612507886',      '20fb59252d8210e4ffef168a233af8cf'
  provider :github,   '362d1578428434bf3242', '260dd17b8c6647daa67b33364ded3f0c7dffc3cd'
end
