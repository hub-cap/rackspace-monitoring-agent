local HostInfo = require('./base').HostInfo

local sigarCtx = require('/sigar').ctx
local sigarutil = require('/base/util/sigar')

local table = require('table')

--[[ Who is logged In ]]--
local WhoInfo = HostInfo:extend()
function WhoInfo:initialize()
  HostInfo.initialize(self)
  local who = sigarCtx:who()
  local fields = {
    'user',
    'device',
    'time',
    'host'
  }

  for i=1, #who do
    local obj = {}
    for _, v in pairs(fields) do
      obj[v] = who[i][v]
    end
    table.insert(self._params, obj)
  end
end

local exports = {}
exports.WhoInfo = WhoInfo
return exports
