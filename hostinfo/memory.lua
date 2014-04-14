local HostInfo = require('./base').HostInfo

local sigarCtx = require('/sigar').ctx
local sigarutil = require('/base/util/sigar')

local table = require('table')

--[[ MemoryInfo ]]--
local MemoryInfo = HostInfo:extend()
function MemoryInfo:initialize()
  HostInfo.initialize(self)
  local swapinfo = sigarCtx:swap()
  local data = sigarCtx:mem()
  local data_fields = {
    'actual_free',
    'actual_used',
    'free',
    'free_percent',
    'ram',
    'total',
    'used',
    'used_percent'
  }
  local swap_metrics = {
    'total',
    'used',
    'free',
    'page_in',
    'page_out'
  }
  if data then
    for _, v in pairs(data_fields) do
      self._params[v] = data[v]
    end
  end
  if swapinfo then
    for _, k in pairs(swap_metrics) do
      self._params['swap_' .. k] = swapinfo[k]
    end
  end
end

local exports = {}
exports.MemoryInfo = MemoryInfo
return exports
