module Merbconf
  class Option
    DEFAULT_OPTIONS = {
      def_file_path: nil,
      rename: nil,
      each: false,
    }

    def self.parse(argv)
      opt_parser = ::OptionParser.new
      option = new(opt_parser)
      opt_parser.banner = "Usage: merbconf [options] <src dir> <dest dir> <template file name>..."

      opt_parser.on("-d DEF_FILE_PATH", "--def=DEF_FILE_PATH", "def file") do |d|
        option[:def_file_path] = d
      end

      opt_parser.on("-h", "--help", "help") do
        $stdout.puts opt_parser
        exit 0
      end

      opt_parser.on("--rename=RENAME", "rename file name") do |n|
        option[:rename] = n
      end

      opt_parser.on("--each", "each") do
        option[:each] = true
      end

      option.args = opt_parser.parse!(argv)[1..-1]

      option
    end

    def initialize(parser)
      @options = DEFAULT_OPTIONS.dup
      @args    = []
      @parser  = parser
    end

    def [](key)
      @options[key]
    end

    def []=(key, val)
      @options[key] = val
    end

    def help
      @parser.help
    end

    def args
      @args
    end

    def args=(args)
      @args = args
    end
  end
end
