# You'll need to add a cronjob to automaticaly syncronize your data with Maptimize running the following command line
#
# IMPORTANT: This is made for BASH shell and is given AS IS so please review it before any use as I can't be hold responsable for any dommage it could make 
#
# rm URL_TO_YOU_CSV ; curl URL_TO_YOU_CSV >> YOUR_CSV_FILE ; curl -u YOUR_AUTHENTICATION_TOKEN:X -X PUT http://www.maptimize.com/api/beta/YOUR_MAP_KEY/import -T YOUR_CSV_FILE -H 'Content-Type: text/csv'

MAPTIMIZE_MAP_KEY = (RAILS_ENV == 'development') ? "DEVELOPMENT_KEY" : "PRODUCTION_KEY"
MAPTIMIZE_MAP_KEY.freeze