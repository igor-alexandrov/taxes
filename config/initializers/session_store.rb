# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_taxes_session',
  :secret      => '3893d581d270488f2790d7d6bd5bbaafea7c053a22f5f8b1d3d9921f177f4ac6f92d501b25c69f81e93a49e6623e026235a4c6a5aa0e80034f43cde9520253c7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
