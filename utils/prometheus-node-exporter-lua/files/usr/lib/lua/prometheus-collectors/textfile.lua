local fs = require "nixio.fs"

local function scrape()
  local mtime_metric = metric("node_textfile_mtime_seconds", "gauge")

  for metrics in fs.glob("/var/prometheus/*.prom") do
    out:write(get_contents(metrics))
    out:write('\n')
    local stat = fs.stat(metrics)
    if stat then
      mtime_metric({ file = metrics }, stat.mtime)
    end
  end
end

return { scrape = scrape }
