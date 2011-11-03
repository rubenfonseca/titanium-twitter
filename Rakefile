PROJECT_NAME = "Twitter"
PROJECT_COMPANY = "0x82"
COMPANY_ID = "com.0x82"

task :default => [:doc]

task :doc do
  %x{appledoc -o documentation -h --no-create-docset --no-repeat-first-par --no-install-docset --project-name "#{PROJECT_NAME}" --project-company "#{PROJECT_COMPANY}" --company-id #{COMPANY_ID} Classes}
end
