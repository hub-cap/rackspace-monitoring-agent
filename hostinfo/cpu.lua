local HostInfo = require('./base').HostInfo

local sigarCtx = require('/sigar').ctx
local sigarutil = require('/base/util/sigar')

local table = require('table')

--[[ CPUInfo ]]--
local CPUInfo = HostInfo:extend()
function CPUInfo:initialize()
  HostInfo.initialize(self)
  local cpus = sigarCtx:cpus()
  for i=1, #cpus do
    local obj = {}
    local info = cpus[i]:info()
    local data = cpus[i]:data()
    local name = 'cpu.' .. i - 1
    local data_fields = {
      'idle',
      'irq',
      'nice',
      'soft_irq',
      'stolen',
      'sys',
      'total',
      'user',
      'wait'
    }
    local info_fields = {
      'mhz',
      'model',
      'total_cores',
      'total_sockets',
      'vendor'
    }

    for _, v in pairs(data_fields) do
      obj[v] = data[v]
    end
    for _, v in pairs(info_fields) do
      obj[v] = info[v]
    end

    obj['name'] = name
    table.insert(self._params, obj)
  end
end

local exports = {}
exports.CPUInfo = CPUInfo
return exports
