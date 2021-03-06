module Merbconf
  class Converter
    def initialize(bind)
      @bind = bind
    end

    def erb(src_path, dest_path, template_file_name, rename = nil)
      template_file_path = File.join(src_path, template_file_name)
      dest_file_name = rename || template_file_name.gsub(".erb", "")
      dest_file_path = File.join(dest_path, dest_file_name)

      template_file = File.open(template_file_path) { |f| f.read }
      File.open(dest_file_path, "w") do |f|
        f.write(ERB.new(template_file).result(@bind))
      end
    end

    def erb_each(src_path, dest_path, *template_file_names)
      template_file_names.each do |template_file_name|
        Dir.glob(File.join(src_path, template_file_name)).each do |template_file_path|
          dest_file_path = File.join(dest_path, File.basename(template_file_path).gsub(".erb", ""))

          template_file = File.open(template_file_path) { |f| f.read }
          File.open(dest_file_path, "w") do |f|
            f.write(ERB.new(template_file).result(@bind))
          end
        end
      end
    end
  end
end
