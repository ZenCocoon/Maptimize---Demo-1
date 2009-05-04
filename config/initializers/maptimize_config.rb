# You'll need to add a cronjob to automatically synchronize your data with Maptimize running the following command line
#
# IMPORTANT: This will overwrite any file called *maptimize.csv* located in your app's tmp folder
# If you like to change this behavior update lib/tasks/maptimize.rake
#
# rake maptimize:sync

MAPTIMIZE_AUTHENTICITY_TOKEN = "AUTHENTICITY_TOKEN"
MAPTIMIZE_AUTHENTICITY_TOKEN.freeze
MAPTIMIZE_MAP_KEY = Rails.env.development? ? "DEVELOPMENT_KEY" : "PRODUCTION_KEY"
MAPTIMIZE_MAP_KEY.freeze