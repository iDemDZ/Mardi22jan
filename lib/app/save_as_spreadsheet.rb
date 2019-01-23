require "google_drive"
require_relative './scrapper'

# Creates a session. This will prompt the credential via command line for the
# first time and save it to config.json file for later usages.
# See this document to learn how to create config.json:
# https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
session = GoogleDrive::Session.from_config("config.json")

# First worksheet of
# https://docs.google.com/spreadsheet/ccc?key=pz7XtlQC-PYx-jrVMJErTcg
# Or https://docs.google.com/a/someone.com/spreadsheets/d/pz7XtlQC-PYx-jrVMJErTcg/edit?usp=drive_web
ws = session.spreadsheet_by_key("1-Ym-e2TQWlhNYlDg5vKjyEV0uYMR6l1mFwIx53act-I").worksheets[0]


# Changes content of cells.
# Changes are not sent to the server until you call ws.save().
ws[1, 1] = "villes"
ws[1, 2] = "emails"

i = 2
Scrapper.new.perform.each_pair { |key, value| 
  ws[i,1] = key 
  ws[i,2] = value
  i += 1
}

# Reloads the worksheet to get changes by other clients.
ws.save
ws.reload