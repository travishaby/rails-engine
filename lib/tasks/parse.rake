desc "Parsing CSV Data"
task :parse => :environment do
  require 'csv'

  puts "Pulling in CSV data!"

  def create_objects(model, file_path)
    CSV.foreach("./lib/assets/#{file_path}",
                headers: true,
                header_converters: :symbol,
                converters: :numeric) do |row|
      puts row
      model.create(row.to_h)
    end
  end

  models_and_file_paths = {Customer => "customers.csv", Merchant => "merchants.csv", Item => "items.csv", Invoice => "invoices.csv", Transaction => "transactions.csv", InvoiceItem => "invoice_items.csv"}

  models_and_file_paths.each do |model, file_path|
    create_objects(model, file_path)
  end
end
