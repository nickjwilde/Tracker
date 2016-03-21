require "omniauth-google-oauth2"
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '161896132272-v52dthoudmqd8d73b2pnhn663bkgrhjs.apps.googleusercontent.com', 'Wno7Xwj7s2WtOX8X2IFzEbML', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end