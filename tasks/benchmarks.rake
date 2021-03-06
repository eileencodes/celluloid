require "timeout"

desc "Run Celluloid benchmarks"
task :benchmark do
  begin
    Timeout.timeout(120) do
      glob = File.expand_path("../../benchmarks/*.rb", __FILE__)
      Dir[glob].each { |benchmark| load benchmark }
    end
  rescue ::Exception, Timeout::Error => ex
    puts "ERROR: Couldn't complete benchmark: #{ex.class}: #{ex}"
    puts "  #{ex.backtrace.join("\n  ")}"

    exit 1 unless ENV["CI"] # Hax for running benchmarks on Travis
  end
end
