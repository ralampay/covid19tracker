namespace :refresh do
  task :all => :environment do
    MatViewCityCountClassification.refresh
    MatViewCountClassification.refresh
  end
end
