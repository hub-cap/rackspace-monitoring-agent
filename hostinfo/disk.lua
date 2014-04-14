local HostInfo = require('./base').HostInfo

local sigarCtx = require('/sigar').ctx
local sigarutil = require('/base/util/sigar')

local table = require('table')

--[[ DiskInfo ]]--
local DiskInfo = HostInfo:extend()
function DiskInfo:initialize()
  HostInfo.initialize(self)
  local disks = sigarutil.diskTargets(sigarCtx)
  local usage_fields = {
    'read_bytes',
    'reads',
    'rtime',
    'time',
    'write_bytes',
    'writes',
    'wtime'
  }
  for i=1, #disks do
    local name = disks[i]:name()
    local usage = disks[i]:usage()
    if name and usage then
      local obj = {}
      for _, v in pairs(usage_fields) do
        obj[v] = usage[v]
      end
      obj['name'] = name
      table.insert(self._params, obj)
    end
  end
end

local exports = {}
exports.DiskInfo = DiskInfo
return exports
