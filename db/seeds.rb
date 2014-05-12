def seed(table_name)
  yaml_file = Rails.root.join('db', 'seeds', "#{table_name}.yml")

  if File.exists? yaml_file
    YAML.load(File.read(yaml_file)).each do |attributes|
      attributes.symbolize_keys!

      yield attributes
    end
  end
end
