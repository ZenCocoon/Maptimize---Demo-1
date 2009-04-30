# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Maptimize---Demo-1_session',
  :secret      => '420f1d280496c72e3c79e8b934675f4577a6695b1f92e90f9c3780991b7a7a4c6033a18f0581c00202f2bd9a6a0758d768e654469789af67b281b11671094114'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
