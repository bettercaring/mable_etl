module MableEtl
  class Controller
    def initialize(configuration)
      @configuration = configuration
      @package_config = configuration.fetch(:packages)
      define_package_methods
    end

    def define_package_methods
      @package_process_methods = package_config.keys.map do |key|
        define_method :"process_#{key}!" do
          data = package_config[:extractor][:type].constantize.new(package_config).run

          package[:loader][:type].constantize.new(package_config, data).run
        end
      end
    end

    def process_all!
      package_process_methods.each do |package_process_methods|
        send(package_process_methods)
      end
    end

    private

    def package_config
      @package_config ||= configuration.fetch(:packages)
    end

    attr_reader :packages, :package_process_methods
  end
end


# Mable::Etl::Controller.new.process_jobs_digests!
# Mable::Etl::Controller.new.process_all!