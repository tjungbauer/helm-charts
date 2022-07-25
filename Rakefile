require "ostruct"
require "yaml"
require "erb"

REPO_URL = "tjungbauer.github.io/helm-charts/"
WEB_ROOT = "public"

class Chart < OpenStruct
  def initialize(source)
    @to_str = source
    super(YAML.load_file(source))
  end

  def self.all
    @all ||= Dir["**/Chart.yaml"].map { |source| new(source) }
  end

  def self.targets
    all.map(&:target)
  end

  def self.from_target(target)
    all.detect { |chart| target == chart.target }
  end

  attr_reader :to_str

  def target
    "#{WEB_ROOT}/#{name}-#{version}.tgz"
  end
end

desc "Build packaged helm charts"
task package: [WEB_ROOT] + Chart.targets

rule ".tgz" => ->(target) { Chart.from_target(target) } do |t|
  sh "mkdir -p #{WEB_ROOT}"
  sh "helm package -d #{WEB_ROOT} -u charts/#{t.source.name}"
end

desc "Index the helm repo"
task index: [WEB_ROOT, "#{WEB_ROOT}/index.yaml"] do
  File.write("#{WEB_ROOT}/index.html", ERB.new(File.read("index.html.erb")).result)
end

rule "#{WEB_ROOT}/index.yaml" => Chart.targets do
  sh "helm repo index #{WEB_ROOT} --url #{REPO_URL}"
end

task :clean do
  sh "rm -rf #{WEB_ROOT}"
end

task default: [:package, :index]
